import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasty_bites/services/auth/bloc/auth_bloc.dart';
import 'package:tasty_bites/services/auth/bloc/auth_event.dart';
import 'package:tasty_bites/services/auth/bloc/auth_state.dart';
import 'package:tasty_bites/utilities/dialogs/error_dialog.dart';
import 'package:tasty_bites/utilities/dialogs/password_reset_email_sent_dialog.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  late final TextEditingController _email;

  @override
  void initState() {
    _email = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateForgotPassword) {
          if (state.hasSentEmail) {
            _email.clear();
            await showPasswordResetSentDialog(context);
          }
          if (state.exception != null) {
            await showErrorDialog(
              context,
              'We could not process your request. Please make sure that you are a registered user, or if not, register a user now by going back one step.',
            );
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
              controller: _email,
              keyboardType: TextInputType.visiblePassword,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: 'Your email adress ...',
                hintStyle: TextStyle(color: Colors.black26),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12),
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black12,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final email = _email.text;
                    context
                        .read<AuthBloc>()
                        .add(AuthEventForgotPassword(email: email));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    shadowColor: const Color.fromARGB(255, 255, 0, 0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                  ),
                  child: const Text('Send me password reset link'),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Have you remembered it?',
                  style: TextStyle(fontSize: 12),
                ),
                TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          const AuthEventLogOut(),
                        );
                  },
                  child: const Text(
                    'Back to login page',
                    style: TextStyle(fontSize: 12),
                  ),
                )
              ],
            ),
            const SizedBox(height: 180),
          ],
        ),
      ),
    );
  }
}
