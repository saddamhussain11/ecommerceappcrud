import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  Future<void> signUpUser() async {
    
    if (password.text != confirmPassword.text) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      Get.snackbar('Success', 'User created successfully');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Get.snackbar('Error', 'This email is already in use. Please use a different email.');
      } else {
        Get.snackbar('Error', e.message ?? 'An error occurred');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
