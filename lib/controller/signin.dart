import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignIn extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<bool> login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      return true; // Login successful
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error Message', e.message ?? 'Unknown error occurred');
      return false; // Login failed
    } catch (e) {
      Get.snackbar('Error Message', e.toString());
      return false; // Login failed
    }
  }
}
