
import 'package:ecommerceappcrud/adminside/addproductscreen.dart';
import 'package:ecommerceappcrud/adminside/optionscreen.dart';
import 'package:ecommerceappcrud/auth/signin.dart';
import 'package:ecommerceappcrud/selection_screen.dart';
import 'package:ecommerceappcrud/userside/homescreen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home:SelectionScreen(),
    );
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false, // Debug banner ko hide kare
//       home: SplashScreen(),
//     );
//   }
// }

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // 5 second ke baad next screen pe jana
//     Timer(Duration(seconds: 5), () {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (context) => SelectionScreen(),
//         ),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white, // Background color set kare
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset('', width: 150, height: 150), // App ka logo
//             SizedBox(height: 20), // Spacing between logo and text
//             Text(
//               'Sale Alert',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.redAccent, // Text color
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

