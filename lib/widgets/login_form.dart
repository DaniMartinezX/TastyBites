import 'package:flutter/material.dart';
import 'package:tasty_bites/widgets/input_text.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      left: 20,
      right: 20,
      child: Column(
        children: <Widget>[
          const InputText(
            keyboardType: TextInputType.emailAddress,
            label: 'Email',
          ),
          Container(
            child: Row(
              children: <Widget>[
                const Expanded(
                  child: InputText(
                    keyboardType: TextInputType.visiblePassword,
                    label: 'Password',
                    obscureText: true,
                    borderEnabled: false,
                  ),
                ),
                TextButton(
                    onPressed: () {}, child: const Text('Forgot Password'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
