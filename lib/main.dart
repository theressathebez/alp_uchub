import 'package:alp_uchub/view/pages/login_page.dart';
import 'package:alp_uchub/view/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view/pages/dashboardStudent_page.dart';
import 'viewmodel/dashboardStudent_viewmodel.dart';
import 'viewmodel/welcome_viewmodel.dart';
import 'viewmodel/auth_viewmodel.dart';
import 'view/pages/welcome_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const IceApp());
}

class IceApp extends StatelessWidget {
  const IceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WelcomeViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => DashboardStudentViewModel()),
      ],
      child: MaterialApp(
        title: 'UC HUB',
        debugShowCheckedModeBanner: false,
        home: const DashboardStudentPage(),
        routes: {
          '/welcome': (context) => WelcomePage(),
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
        },
      ),
    );
  }
}
