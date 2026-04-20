import 'package:flutter/material.dart';

//для подтверждения действий
void showConfirmDialog({
  required BuildContext context,
  required String title,
  required String message,
  required VoidCallback onConfirm,
  String confirmText = "Confirm", 

}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Colors.black, width: 1.2),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Text(title, 
        textAlign: TextAlign.center, 
        style: const TextStyle(fontWeight: FontWeight.bold)
      ),
      content: Text(message, textAlign: TextAlign.center),
      actions: [
        // кнопка отмены
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
        ),
        // кнопка подтверждения
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onConfirm();
          },
          child: Text(
            confirmText, 
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary, 
              fontWeight: FontWeight.bold
            )
          ),
        ),
      ],
    ),
  );
}

// для сообщений об ошибках и тд
void showMyDialog({
  required BuildContext context,
  required String title,
  required String message,
  bool isError = true,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder( 
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Colors.black, width: 1.2),),
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Column(
        children: [
          
          const SizedBox(height: 15),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16),
      ),
      actions: [
        Center(
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "OK",
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary
              ),
            ),
          ),
        ),
      ],
    ),
  );
}