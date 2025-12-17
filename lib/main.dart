import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart'; // Jika pakai dotenv
import 'viewmodel/welcome_viewmodel.dart';
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
      ],
      child: MaterialApp(
        title: 'ICE Portal',
        debugShowCheckedModeBanner: false,
        home: const WelcomePage(),
        routes: {
          // '/login': (context) => const LoginPage(), // Daftarkan rute lain disini
        },
      ),
    );
  }
}