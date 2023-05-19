import 'package:flutter/material.dart';
import 'package:tasty_bites/utils/responsive.dart';
import 'package:tasty_bites/widgets/circle.dart';
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
                const LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
