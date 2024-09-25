import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class UpdateProductService {
  // Method to update a product in Firestore
  Future<void> updateProduct(String productId, String name, double price, String? imagePath) async {
    final docRef = FirebaseFirestore.instance.collection('products').doc(productId);

    // If a new image is picked, upload it to Firebase Storage and get the URL
    if (imagePath != null) {
      final storageRef = FirebaseStorage.instance.ref().child('product_images').child('$productId.jpg');
      await storageRef.putFile(File(imagePath));
      final imageUrl = await storageRef.getDownloadURL();

      await docRef.update({
        'name': name,
        'price': price,
        'imageUrl': imageUrl,
      });
    } else {
      // If no new image is picked, just update the name and price
      await docRef.update({
        'name': name,
        'price': price,
      });
    }
  }
}
