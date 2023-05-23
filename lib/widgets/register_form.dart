import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasty_bites/services/auth/auth_exceptions.dart';
import 'package:tasty_bites/services/auth/bloc/auth_bloc.dart';
import 'package:tasty_bites/services/auth/bloc/auth_event.dart';
import 'package:tasty_bites/services/auth/bloc/auth_state.dart';
import 'package:tasty_bites/utilities/dialogs/error_dialog.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _name;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _name = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateRegistering) {
          if (state.exception is WeakPasswordAuthException) {
            await showErrorDialog(context, 'Weak password');
          } else if (state.exception is EmailAlreadyInUseAuthException) {
            await showErrorDialog(context, 'Email is already in use');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Failed to register');
          } else if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(context, 'Invalid email');
          }
        }
      },
      child: Positioned(
        bottom: 30,
        left: 20,
        right: 20,
        child: Column(
          children: <Widget>[
            TextField(
              controller: _name,
              keyboardType: TextInputType.visiblePassword,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: 'User name',
                hintStyle: TextStyle(color: Colors.black26),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.black26),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _password,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.black26),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final email = _email.text;
                    final password = _password.text;
                    context.read<AuthBloc>().add(
                          AuthEventRegister(
                            email,
                            password,
                          ),
                        );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    shadowColor: const Color.fromARGB(255, 255, 0, 0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                  ),
                  child: const Text('Sign up'),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Already have an account?'),
                TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          const AuthEventLogOut(),
                        );
                  },
                  child: const Text('Sign in'),
                )
              ],
            ),
            const SizedBox(height: 130),
          ],
        ),
      ),
    );
  }
}
