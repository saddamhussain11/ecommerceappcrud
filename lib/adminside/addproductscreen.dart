import 'dart:io';
import 'package:ecommerceappcrud/adminside/optionscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ecommerceappcrud/services/addproductservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool _isSaving = false; // To track the saving state

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<String> _uploadImage(File image) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
      // Generate a unique filename using timestamp
      final fileName = '${uid}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('product_images')
          .child(fileName); // Use unique filename
      await storageRef.putFile(image);
      return await storageRef.getDownloadURL();
    } catch (e) {
      print('Image upload error: $e');
      throw e;
    }
  }

  Future<void> _saveProduct() async {
    if (_nameController.text.isEmpty || _priceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product name and price cannot be empty')),
      );
      return;
    }

    setState(() {
      _isSaving = true; // Set saving state to true
    });

    try {
      String? imageUrl;
      if (_imageFile != null) {
        print('Uploading image...');
        imageUrl = await _uploadImage(_imageFile!);
      }

      print('Saving product: ${_nameController.text}, ${_priceController.text}, Image URL: $imageUrl');

      await FirestoreService().saveProduct(
        _nameController.text,
        _priceController.text,
        imageUrl,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product saved successfully')),
      );

      // Navigate to the next screen after saving the product
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SelectionScreen1()),
      );
    } catch (e) {
      print('Product save error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save product. Please try again.')),
      );
    } finally {
      setState(() {
        _isSaving = false; // Set saving state to false when done
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                child: _imageFile == null
                    ? Icon(Icons.add_a_photo, size: 50, color: Colors.white)
                    : ClipOval(
                        child: Image.file(
                          _imageFile!,
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                        ),
                      ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Product Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: 'Product Price',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isSaving ? null : _saveProduct, // Disable button when saving
              child: _isSaving
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        color: Colors.white,
                      ),
                    )
                  : Text('Save Product'),
            ),
          ],
        ),
      ),
    );
  }
}
