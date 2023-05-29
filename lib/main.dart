import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasty_bites/constants/routes.dart';
import 'package:tasty_bites/helpers/loading/loading_screen.dart';
import 'package:tasty_bites/pages/food_info_page.dart';
import 'package:tasty_bites/pages/forgot_password_page.dart';
import 'package:tasty_bites/pages/login_page.dart';
import 'package:tasty_bites/pages/random_food_page.dart';
import 'package:tasty_bites/pages/register_page.dart';
import 'package:tasty_bites/pages/search_food_page.dart';
import 'package:tasty_bites/pages/verify_email_page.dart';
import 'package:tasty_bites/services/auth/bloc/auth_bloc.dart';
import 'package:tasty_bites/services/auth/bloc/auth_event.dart';
import 'package:tasty_bites/services/auth/bloc/auth_state.dart';
import 'package:tasty_bites/services/auth/firebase_auth_provider.dart';

void main() {
  //1º---Binding
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
      routes: {
        randomFoodRoute: (context) => const RandomFoodPage(),
        searchFoodRoute: (context) => const SearchFood(),
        FoodInfoPage.routeName: (context) => const FoodInfoPage(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
            context: context,
            text: state.loadingText ?? 'Please wait a moment',
          );
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const RandomFoodPage();
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailPage();
        } else if (state is AuthStateLoggedOut) {
          return const LoginPage();
        } else if (state is AuthStateForgotPassword) {
          return const ForgotPasswordPage();
        } else if (state is AuthStateRegistering) {
          return const RegisterPage();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
