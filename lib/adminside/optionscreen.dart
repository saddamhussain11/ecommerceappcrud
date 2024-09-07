
import 'package:ecommerceappcrud/adminside/addproductscreen.dart';
import 'package:ecommerceappcrud/adminside/showproductscreen.dart';
import 'package:flutter/material.dart';

class SelectionScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background color set kare
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sale Alert',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent, // App name color
              ),
            ),
            SizedBox(height: 40), // Spacing between name and buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProductScreen ()),
                );
              },
              child: Text('Add Product'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(fontSize: 20),
                backgroundColor: Colors.blueAccent, // Button color
              ),
            ),
            SizedBox(height: 20), // Spacing between buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductListScreen()),
                );
              },
              child: Text('Show Product'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(fontSize: 20),
                backgroundColor: Colors.greenAccent, // Button color
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// User Side Screen



