import 'package:bc_final_project/constants/r.dart';
import 'package:bc_final_project/firebase_options.dart';
import 'package:bc_final_project/views/login_screen.dart';
import 'package:bc_final_project/views/main_screen.dart';
import 'package:bc_final_project/views/register.screen.dart';
import 'package:bc_final_project/views/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Final Project',
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          appBarTheme: AppBarTheme(
            backgroundColor: R.colors.primary,
          ),
          primarySwatch: Colors.blue,
        ),
        initialRoute: "/",
        routes: {
          "/": (context) => const SplashScreen(),
          LoginScreen.route: (context) => const LoginScreen(),
          RegisterScreen.route: (context) => const RegisterScreen(),
          MainScreen.route: (context) => const MainScreen(),
        });
  }
}
