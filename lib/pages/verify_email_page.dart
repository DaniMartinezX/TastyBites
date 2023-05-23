import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasty_bites/services/auth/bloc/auth_bloc.dart';
import 'package:tasty_bites/services/auth/bloc/auth_event.dart';
import 'package:tasty_bites/utilities/responsive.dart';
import 'package:tasty_bites/widgets/figures/circle.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
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
              child: Stack(children: <Widget>[
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
                          "Verify email",
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
                            "We've sent you an email verification. Please open it so verify your account. If you haven´t received a verification email yet, press the button below.",
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
                              'https://t3.ftcdn.net/jpg/03/57/18/66/360_F_357186696_iyzZk8MNLmoAY13k2bNjqGHugsxbLYIt.jpg',
                              width: 90,
                              height: 90,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    TextButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              const AuthEventSendEmailVerification(),
                            );
                      },
                      child: const Text('Send email verification'),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () async {
                        context.read<AuthBloc>().add(
                              const AuthEventLogOut(),
                            );
                      },
                      child: const Text('Restart'),
                    )
                  ],
                ),
              ]),
            ),
          )),
    );
  }
}
