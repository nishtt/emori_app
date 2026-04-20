import 'package:flutter/material.dart';
import 'package:mood_app/auth/auth_service.dart';
import 'package:mood_app/components/my_button.dart';
import 'package:mood_app/components/my_textfield.dart';
import 'package:mood_app/components/my_alert_dialog.dart'; 

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  void resetPassword() async {
    final authService = AuthService();
    //поле пустое
    if (_emailController.text.isEmpty) {
      showMyDialog(
        context: context,
        title: "Empty email",
        message: "Please enter your email to reset password.",
      );
      return;
    }

    try {
      await authService.sendPasswordResetEmail(_emailController.text.trim());
      //сообщение об успехе
      if (mounted) {
        showMyDialog(
          context: context, 
          title: "Success!", 
          message: "If an account exists for this email, a reset link has been sent.",
          isError: false,
        );
      }
      //сообщение об ошибке
    } catch (e) {
      if (mounted) {
        String errorMessage = e.toString().replaceAll("Exception: ", "");
        
        showMyDialog(
          context: context, 
          title: "Error", 
          message: errorMessage,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 130),
            const Text(
              "Forgot Password?",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            
            const SizedBox(height: 10),
            
            const Text(
              "Enter your email and we will send you a link to reset your password",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            
            const SizedBox(height: 25),
            
            MyTextField(
              hintText: "Email",
              obscureText: false,
              controller: _emailController,
            ),
            
            const SizedBox(height: 25),
            
            MyButton(text: "Send Link", onTap: resetPassword),
          ],
        ),
      ),
    );
  }
}