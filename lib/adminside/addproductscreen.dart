import 'dart:io'; // To handle File
import 'package:ecommerceappcrud/widget/commontextfiled.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import the image picker package
 // Import the CommonTextField widget

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  File? _selectedImage; // To store the selected image file

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path); // Set the selected image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Display the selected image or a placeholder
            GestureDetector(
              onTap: _pickImage, // Trigger image picker when tapped
              child: _selectedImage != null
                  ? Image.file(
                      _selectedImage!,
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/image/download (3).jpeg', // Placeholder image
                      width: 150,
                      height: 150,
                    ),
            ),
            SizedBox(height: 20),
            
            // Product Name TextField
            CommonTextField(
              controller: productNameController,
              hintText: "Enter product name",
              prefixIcon: Icons.shopping_bag,
            ),
            SizedBox(height: 16),
            
            // Product Price TextField
            CommonTextField(
              controller: productPriceController,
              hintText: "Enter product price",
              prefixIcon: Icons.attach_money,
              keyboardType: TextInputType.number, // Numeric keyboard for price
            ),
            SizedBox(height: 20),
            
            // Add Button
            ElevatedButton(
              onPressed: () {
                // Handle add product logic here
                String productName = productNameController.text;
                String productPrice = productPriceController.text;

                if (_selectedImage == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please select an image!")),
                  );
                  return;
                }

                print("Product Name: $productName");
                print("Product Price: $productPrice");
                print("Selected Image Path: ${_selectedImage!.path}");

                // You can add the logic to store the product details
              },
              child: Text("Add Product"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

