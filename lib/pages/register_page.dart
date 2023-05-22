import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasty_bites/utilities/responsive.dart';
import 'package:tasty_bites/widgets/figures/circle.dart';
import 'package:tasty_bites/widgets/register_form.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                    const SizedBox(height: 80),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Hello!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(225, 255, 255, 255),
                          ),
                        )
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Sign up to get started",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
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
                              'https://www.pngplay.com/wp-content/uploads/12/User-Avatar-Profile-PNG-Pic-Clip-Art-Background.png',
                              width: 90,
                              height: 90,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CupertinoButton(
                            padding: EdgeInsets.zero,
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.pinkAccent,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  )),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const RegisterForm(),
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
                          Navigator.pop(context);
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
