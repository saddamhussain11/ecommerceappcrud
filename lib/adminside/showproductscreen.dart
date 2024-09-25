import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceappcrud/Module/product.dart';
import 'package:ecommerceappcrud/services/addproductservice.dart';
import 'package:ecommerceappcrud/services/delete_product.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  // Stream to fetch products from Firebase
  Stream<List<Product>> _fetchProducts() {
    return FirebaseFirestore.instance
        .collection('products')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Product(
          id :doc.id,
          name: doc['name'],
          price: doc['price'],
          imagePath: doc['imageUrl'], // Ensure this matches the saved field
        );
      }).toList();
    });
  }
 String update='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Product>>(
        stream: _fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading products"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No products available"));
          }

          final productList = snapshot.data!;

          return ListView.builder(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              final product = productList[index];

              return ListTile(
                leading: product.imagePath != null
                    ? Image.network(
                        product.imagePath!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                    : Icon(Icons.image_not_supported), // Fallback for no image
                title: Text(product.name),
                subtitle: Text("\$${product.price}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () async{
                        // Placeholder for edit action
                        //  bool confirmupdate =
                        //     await _ConfirmationDialog(context);
                        // if (confirmupdate) {
                        //   ProductService().updateproduct(product.id);
                        // }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () async{
                        // Placeholder for delete action
                          bool confirmDelete =
                            await _showConfirmationDialog(context);
                        if (confirmDelete) {
                          ProductService().deleteProduct(product.id);
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

Future<bool> _ConfirmationDialog(BuildContext context) async{
  return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Edit Product'),
            content: TextField(
                  onChanged: (value) {
                  
                  },
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Update'),
              ),
            ],
          ),
        ) ??
        false;
}


  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Delete Product'),
            content: Text('Are you sure you want to delete this product?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Delete'),
              ),
            ],
          ),
        ) ??
        false;
  }



