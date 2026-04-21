import 'package:flutter/material.dart';
import 'package:mood_app/auth/auth_service.dart';
import 'package:mood_app/components/my_button.dart';
import 'package:mood_app/components/my_textfield.dart';
import 'package:mood_app/components/my_alert_dialog.dart';
import 'package:mood_app/l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;

    // валидация пустых полей
    if (_emailController.text.isEmpty || _pwController.text.isEmpty) {
      showMyDialog(context: context, title: l10n.oops, message: l10n.fillAllFields);
      return;
    }

    // валидация длины пароля 
    if (_pwController.text.length < 6) {
      showMyDialog(context: context, title: l10n.weakPassword, message: l10n.passwordLengthError);
      return;
    }

    // проверка совпадения паролей
    if (_pwController.text != _confirmPwController.text) {
      showMyDialog(context: context, title: l10n.oops, message: l10n.passwordsNoMatch);
      return;
    }

    setState(() => _isLoading = true); 

    try {
      await _auth.signUpWithEmailPassword(_emailController.text.trim(), _pwController.text.trim());
    } catch (e) {
      if (mounted) {
        showMyDialog(
          context: context, 
          title: l10n.registrationError, 
          message: e.toString().replaceAll("Exception: ", "")
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false); 
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView( 
          child: Column (
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //регистрация
              Text(
                l10n.signUp,
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
                hintText: l10n.password,
                obscureText: true,
                controller: _pwController,
              ),
              const SizedBox(height: 25),
              //поле подтверждения пароля
              MyTextField(
                hintText: l10n.confirmPassword,
                obscureText: true,
                controller: _confirmPwController,
              ),
              const SizedBox(height: 25),

              // кнопка регистрации с индикатором
              _isLoading 
                ? const CircularProgressIndicator() 
                : MyButton(
                    text: l10n.register,
                    onTap: () => register(context),
                  ),

              const SizedBox(height: 20),
              //переход к странице входа
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(l10n.alreadyHaveAccount),
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      l10n.loginNow,
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