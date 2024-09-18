import 'package:ecommerceappcrud/controller/forgat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  // Initialize ForgotPasswordService
  final forgatservices = Get.put(ForgatPasword());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: forgatservices.emailcontroller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter text here',
              ),
                validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async{
               await forgatservices.resetpasword();
              },
              child: const Text('Click Me'),
            ),
          ],
        ),
      ),
    );
  }
}
