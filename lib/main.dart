import 'package:flutter/material.dart';
import 'package:tasty_bites/constants/routes.dart';
import 'package:tasty_bites/pages/forgot_password_page.dart';
import 'package:tasty_bites/pages/home_page.dart';
import 'package:tasty_bites/pages/register_page.dart';
import 'package:tasty_bites/widgets/login_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: {
        registerRoute: (_) => const RegisterPage(),
        loginRoute: (_) => const LoginForm(),
        forgotPasswordRoute: (_) => const ForgotPasswordPage()
      },
    );
  }
}
