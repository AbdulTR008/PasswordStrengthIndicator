import 'package:flutter/material.dart';
import 'package:password_strength_checker/password_strength_checker.dart';

class PasswordGenerator2 extends StatefulWidget {
  const PasswordGenerator2({super.key});

  @override
  State<PasswordGenerator2> createState() => _PasswordGenerator2State();
}

class _PasswordGenerator2State extends State<PasswordGenerator2> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  var _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Password Indicator'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PasswordStrengthFormChecker(
                passwordGeneratorConfiguration:
                    const PasswordGeneratorConfiguration(
                  length: 14,
                  minUppercase: 8,
                ),
                minimumStrengthRequired: PasswordStrength.weak,
                onChanged: (password, notifier) {
                  notifier.value = PasswordStrength.calculate(text: password);
                },
                textFormFieldConfiguration: TextFormFieldConfiguration(
                  controller: _passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(_obscureText
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                ),
                showGenerator: true,
                onPasswordGenerated: (password, notifier) {
                  debugPrint('$password - length: ${password.length}');
            
                  notifier.value = PasswordStrength.calculate(text: password);
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.maxFinite,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
