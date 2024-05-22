import 'package:flutter/material.dart';
import 'package:password_strength_checker/password_strength_checker.dart';
import './password_generator.dart';

class PasswordStrength1 extends StatefulWidget {
  const PasswordStrength1({super.key});

  @override
  State<PasswordStrength1> createState() => _PasswordStrength1State();
}

class _PasswordStrength1State extends State<PasswordStrength1> {
  final _passwordController = TextEditingController();

  final passNotifier = ValueNotifier<PasswordStrength?>(null);
  bool _obscureText = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _passwordController.dispose();
  }

  void _generatePassword() {
    const config = PasswordGeneratorConfiguration(
      length: 14,
      minUppercase: 1,

      // ...
    );

    final passwordGenerator = PasswordGenerator.fromConfig(
      configuration: config,
    );

    final password = passwordGenerator.generate();

    _passwordController.text = password;

    onChange(password);
  }

  onChange(value) {
    passNotifier.value = PasswordStrength.calculate(text: value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Password Indicator'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  obscureText: _obscureText,
                  controller: _passwordController,
                  onChanged: (value) => onChange(value),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
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
                    hintText: "Enter your password",
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.7),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                PasswordStrengthChecker(
                  strength: passNotifier,
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: _generatePassword,
                    child: const Text('Generate Password')),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const PasswordGenerator2()));
                    },
                    child: const Text('PasswordGenerator')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
