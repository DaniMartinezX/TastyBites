import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasty_bites/services/auth/bloc/auth_bloc.dart';
import 'package:tasty_bites/services/auth/bloc/auth_event.dart';
import 'package:tasty_bites/utilities/responsive.dart';
import 'package:tasty_bites/widgets/figures/circle.dart';
import 'package:tasty_bites/widgets/forgot_password_form.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: responsive.height,
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -(size.width * 0.8) * 0.3,
                  left: -(size.width * 0.8) * 0.2,
                  child: Circle(
                    size: size.width * 0.8,
                    colors: const [
                      Colors.deepPurpleAccent,
                      Color.fromARGB(255, 234, 79, 32),
                    ],
                  ),
                ),
                Positioned(
                  top: -(size.width * 0.8) * 0.2,
                  right: -(size.width * 0.8) * 0.2,
                  child: Circle(
                    size: size.width * 0.8,
                    colors: const [
                      Colors.deepPurpleAccent,
                      Color.fromARGB(255, 234, 79, 32),
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: responsive.dp(3),
                    ),
                    const SizedBox(height: 60),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Forgot password",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(225, 255, 255, 255),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 300,
                          child: Text(
                            "If you forgot your password, simply enter email and we send you a password reset link",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Stack(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 20,
                                    color: Colors.black26,
                                    offset: Offset(0, 20))
                              ]),
                          child: ClipOval(
                            child: Image.network(
                              'https://img.freepik.com/free-vector/forgot-password-concept-illustration_114360-1095.jpg?w=2000',
                              width: 90,
                              height: 90,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const ForgotPasswordForm(),
                Positioned(
                    left: 15,
                    top: 15,
                    child: SafeArea(
                      child: CupertinoButton(
                        color: Colors.black26,
                        padding: const EdgeInsets.all(10),
                        borderRadius: BorderRadius.circular(30),
                        child: const Icon(Icons.arrow_back),
                        onPressed: () {
                          context.read<AuthBloc>().add(
                                const AuthEventLogOut(),
                              );
                        },
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
