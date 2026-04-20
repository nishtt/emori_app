import 'package:flutter/material.dart';
import 'package:mood_app/auth/auth_service.dart';
import 'package:mood_app/components/my_button.dart';
import 'package:mood_app/components/my_textfield.dart';
import 'package:mood_app/components/my_alert_dialog.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();
  bool _isLoading = false; 

  void register(BuildContext context) async {
    final _auth = AuthService();

    // валидация пустых полей
    if (_emailController.text.isEmpty || _pwController.text.isEmpty) {
      showMyDialog(context: context, title: "Oops!", message: "Please fill in all fields.");
      return;
    }

    // валидация длины пароля 
    if (_pwController.text.length < 6) {
      showMyDialog(context: context, title: "Weak Password", message: "Password must be at least 6 characters.");
      return;
    }

    // проверка совпадения паролей
    if (_pwController.text != _confirmPwController.text) {
      showMyDialog(context: context, title: "Oops!", message: "Passwords do not match!");
      return;
    }

    setState(() => _isLoading = true); 

    try {
      await _auth.signUpWithEmailPassword(_emailController.text.trim(), _pwController.text.trim());
    } catch (e) {
      if (mounted) {
        showMyDialog(
          context: context, 
          title: "Registration Error", 
          message: e.toString().replaceAll("Exception: ", "")
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView( 
          child: Column (
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //регистрация
              Text(
                "Sign up",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 32
                ),
              ),
              const SizedBox(height: 25),
              //поле email
              MyTextField(
                hintText: "Email",
                obscureText: false,
                controller: _emailController,
              ),
              const SizedBox(height: 25),
              //поле пароль
              MyTextField(
                hintText: "Password",
                obscureText: true,
                controller: _pwController,
              ),
              const SizedBox(height: 25),
              //поле подтверждения пароля
              MyTextField(
                hintText: "Confirm password",
                obscureText: true,
                controller: _confirmPwController,
              ),
              const SizedBox(height: 25),

              // кнопка регистрации с индикатором
              _isLoading 
                ? const CircularProgressIndicator() 
                : MyButton(
                    text: "Register",
                    onTap: () => register(context),
                  ),

              const SizedBox(height: 20),
              //переход к странице входа
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      "Login now",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationThickness: 2.0
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}