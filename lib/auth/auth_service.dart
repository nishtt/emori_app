import 'package:firebase_auth/firebase_auth.dart';

class AuthService {


final FirebaseAuth _auth = FirebaseAuth.instance;

//вход

Future<UserCredential> signInWithEmailPassword(String email, String password) async {
  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email, 
      password: password
    );
    return userCredential;
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case 'invalid-credential':
        throw Exception("Invalid email or password.");
      case 'too-many-requests':
        throw Exception("Too many failed attempts. Try again later.");
      default:
        
        throw Exception(e.message ?? "An error occurred during login.");
    }
  }
}

//регистрация

Future<UserCredential> signUpWithEmailPassword(String email, String password) async {
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email, 
      password: password
    );
    return userCredential;
  } on FirebaseAuthException catch (e) {
    
    switch (e.code) {
      case 'weak-password':
        throw Exception("The password is too weak. Use at least 6 characters.");
      case 'email-already-in-use':
        throw Exception("An account already exists for that email.");
      case 'invalid-email':
        throw Exception("The email address is not valid.");
      default:
        throw Exception(e.message ?? "An unknown error occurred.");
    }
  }
}

//выход
Future<void> signOut() async {
  return await _auth.signOut();
}

// сброс пароля

Future<void> sendPasswordResetEmail(String email) async {
  try {
    await _auth.sendPasswordResetEmail(email: email);
  } on FirebaseAuthException catch (e) {
    String message = "Error";
    if (e.code == 'user-not-found') {
      message = "User not found.";
    } else if (e.code == 'invalid-email') {
      message = "Invalid email format.";
    }
    throw Exception(message);
  }
}
//ошибки

}