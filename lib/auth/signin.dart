import 'package:ecommerceappcrud/auth/forgat.dart';
import 'package:ecommerceappcrud/auth/signup.dart';
import 'package:ecommerceappcrud/controller/signin.dart';
import 'package:ecommerceappcrud/selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isloding = false;
  
  final _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;

  final SignIn signinservices = Get.put(SignIn());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Logo
                const Center(child: FlutterLogo(size: 100)),

                const SizedBox(height: 32),

                // Email Field
                TextFormField(
                  controller: signinservices.email,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Password Field
                TextFormField(
                  controller: signinservices.password,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.visibility),
                      onPressed: () {
                        // Toggle password visibility
                        setState(() {
                          // Add code to toggle visibility if needed
                        });
                      },
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty ) {
                      return 'Please enter your password';
                    } if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Remember Me Checkbox
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (bool? value) {
                        setState(() {
                          _rememberMe = value ?? false;
                        });
                      },
                    ),
                    const Text('Remember Me'),
                  ],
                ),

                const SizedBox(height: 16),

                // Sign In Button
              ElevatedButton(
  onPressed: () async {
    setState(() {
      isloding=true;
    });
    if (_formKey.currentState?.validate() ?? false) {
      bool isSuccess = await signinservices.login();
      if (isSuccess) {
        // Navigate to home screen only if login is successful
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SelectionScreen()),
        );
      } else {
        // Show an error message if login fails
        Get.snackbar(
          'Error',
          'Incorrect email or password',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }setState(() {
      isloding=false;
    });
  },
  style: ElevatedButton.styleFrom(
    minimumSize: const Size(double.infinity, 36),
  ),
  child:isloding?const CircularProgressIndicator(): const Text('Sign In'),
),

                const SizedBox(height: 16),

                // Forgot Password
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgotPassword()),
                    );
                  },
                  child: const Text('Forgot your password?'),
                ),

                const SizedBox(height: 16),

                // Sign Up
                TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                  },
                    
                 
                  child: const Text("Don't have an account? Sign Up"),
                ),

                const SizedBox(height: 16),

                // Social Media Sign-In
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
