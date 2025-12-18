import 'package:alp_uchub/view/pages/login_page.dart';
import 'package:alp_uchub/view/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart'; // Jika pakai dotenv
import 'viewmodel/welcome_viewmodel.dart';
import 'viewmodel/auth_viewmodel.dart';
import 'view/pages/welcome_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load(fileName: ".env"); // Uncomment jika sudah setup env

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
      ],
      child: MaterialApp(
        title: 'UC HUB',
        debugShowCheckedModeBanner: false,
        home: const WelcomePage(),
        routes: {
          '/welcome': (context) => WelcomePage(),
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
        },
      ),
    );
  }
}
