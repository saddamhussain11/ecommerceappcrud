import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgatPasword extends GetxController {
  TextEditingController emailcontroller = TextEditingController();
  
  Future<void> resetpasword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailcontroller.text);
      Get.snackbar('Success', 'Password reset email sent successfully.',
          snackPosition: SnackPosition.BOTTOM);
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred. Please try again.';
      if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      } else if (e.code == 'user-not-found') {
        errorMessage = 'No user found with this email address.';
      }
      Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      // Handle any other types of exceptions
      Get.snackbar('Error', 'An unexpected error occurred. Please try again.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
