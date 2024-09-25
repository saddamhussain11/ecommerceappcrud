import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveProduct(String name, String price, String? imageUrl) async {
    try {
      await _db.collection('products').add({
        'name': name,
        'price': price,
        'imageUrl': imageUrl, // Ensure this field is consistent
      });
      print('Product saved successfully');
    } catch (e) {
      print('Error saving product: $e');
      throw e;
    }
  }

  void deletproduct(param0) {}
}
