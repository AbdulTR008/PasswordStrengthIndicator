import 'package:flutter/material.dart';
import 'package:password_strength_checker/password_strength_checker.dart';

class PasswordStrengthFrom extends StatefulWidget {
  const PasswordStrengthFrom({super.key});

  @override
  State<PasswordStrengthFrom> createState() => _PasswordStrengthFromState();
}

class _PasswordStrengthFromState extends State<PasswordStrengthFrom> {
  // final _passwordController = TextEditingController();
  // final _passwordFormController = TextEditingController();

  final passFormNotifier = ValueNotifier<PasswordStrength?>(null);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Password Form Indicator'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PasswordStrengthFormChecker(
                    passwordStrengthCheckerConfiguration:
                        const PasswordStrengthCheckerConfiguration(),
                    minimumStrengthRequired: PasswordStrength.secure,
                    onChanged: (password, notifier) {
                      passFormNotifier.value =
                          PasswordStrength.calculate(text: password);
                    },
                    textFormFieldConfiguration: TextFormFieldConfiguration(
                      controller: TextEditingController(),
                      decoration: const InputDecoration(
                        errorStyle:
                            TextStyle(height: 0), // remove error text space
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(onPressed: () {}, child: const Text('Submi')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//  v  