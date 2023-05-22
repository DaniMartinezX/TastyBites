import 'package:flutter/material.dart';
import 'package:tasty_bites/utilities/responsive.dart';
import 'package:tasty_bites/widgets/figures/circle.dart';
import 'package:tasty_bites/widgets/login_form.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  top: -(size.width * 0.8) * 0.2,
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
                  top: -(size.width * 0.8) * 0.3,
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
                    const SizedBox(height: 70),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Tasty bites",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 26,
                            color: Color.fromARGB(225, 255, 255, 255),
                          ),
                        )
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Welcome back",
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
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZoUNmHqCYmQfa48D_H08tew0jlBNRVpAO9A&usqp=CAU',
                              width: 90,
                              height: 90,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
