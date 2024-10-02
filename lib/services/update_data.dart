import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UpdateProductService {
  final db = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  Future<void> updateProduct(String productId, String updatedName, var updatedPrice, File? imageFile) async {
    String? imageUrl;

    // Step 1: If an image file is provided, upload it to Firebase Storage
    if (imageFile != null) {
      try {
        final ref = storage.ref().child('product_images').child('$productId.jpg');
        UploadTask uploadTask = ref.putFile(imageFile);

        final snapshot = await uploadTask.whenComplete(() => {});
        imageUrl = await snapshot.ref.getDownloadURL();
      } catch (e) {
        print('Error uploading image: $e');
        // You might want to throw an error here or handle it
      }
    }

    // Step 2: Update the product in Firestore
    try {
      Map<String, dynamic> productData = {
        'name': updatedName,
        'price': updatedPrice,
      };

      // Only update the imageUrl if a new image was uploaded
      if (imageUrl != null) {
        productData['imageUrl'] = imageUrl;
      }

      await db.collection('products').doc(productId).update(productData);
    } catch (e) {
      print('Error updating product: $e');
    }
  }
}
