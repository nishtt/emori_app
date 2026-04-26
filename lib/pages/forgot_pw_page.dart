import 'package:flutter/material.dart';
import 'package:mood_app/auth/auth_service.dart';
import 'package:mood_app/components/my_button.dart';
import 'package:mood_app/components/my_textfield.dart';
import 'package:mood_app/components/my_alert_dialog.dart'; 
import 'package:mood_app/l10n/app_localizations.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  
  void resetPassword() async {
    final authService = AuthService();
    final l10n = AppLocalizations.of(context)!;
    //поле пустое
    if (_emailController.text.isEmpty) {
      showMyDialog(
        context: context,
        title: l10n.emptyEmail,
        message: l10n.enterEmailToReset,
      );
      return;
    }

    try {
      await authService.sendPasswordResetEmail(_emailController.text.trim());
      //сообщение об успехе
      if (mounted) {
        showMyDialog(
          context: context, 
          title: l10n.success, 
          message: l10n.resetLinkSent,
          isError: false,
        );
      }
      //сообщение об ошибке
    } catch (e) {
      if (mounted) {
        String errorMessage = e.toString().replaceAll("Exception: ", "");
        
        showMyDialog(
          context: context, 
          title: l10n.error, 
          message: errorMessage,
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 130),
            Text(
              l10n.forgotPassword,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            
            const SizedBox(height: 10),
            
            Text(
              l10n.resetInstructions,
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
            
            MyButton(text: l10n.sendLink, onTap: resetPassword),
          ],
        ),
      ),
    );
  }
}