import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProductService {
  final CollectionReference _productCollection =
      FirebaseFirestore.instance.collection('products');

  // Method to delete product by document ID
  Future<void> deleteProduct(String productId) async {
    try {
      await _productCollection.doc(productId).delete();
      print('Product deleted successfully');
    } catch (e) {
      print('Failed to delete product: $e');
    }
  }

}
