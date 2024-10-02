import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceappcrud/services/delete_product.dart';
import 'package:ecommerceappcrud/services/update_data.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final db = FirebaseFirestore.instance;
 
  File? _imageFile;

  final picker = ImagePicker();

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: db.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading products"));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No products available"));
          }

          final productList = snapshot.data!.docs;

          return ListView.builder(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              var product = productList[index];
              var productId = product.id;
              var imageUrl = product["imageUrl"]; // Ensure this field is correct in Firestore
              var productName = product["name"] ?? "No Name";
              var productPrice = product['price'] ?? 0.00;

              return ListTile(
                leading: imageUrl != null && imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.broken_image, size: 60);
                        },
                      )
                    : Icon(Icons.broken_image, size: 60),
                title: Text(productName),
                subtitle: Text("\$${productPrice}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        _showEditDialog(context, productId, productName, productPrice, imageUrl);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        bool confirmDelete = await _showConfirmationDialog(context);
                        if (confirmDelete) {
                          ProductService().deleteProduct(productId);
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

  // Edit product dialog
  Future<void> _showEditDialog(BuildContext context, String productId, String currentName, var currentPrice, String currentImageUrl) async {
    final nameController = TextEditingController(text: currentName);
    final priceController = TextEditingController(text: '$currentPrice');
    _imageFile = null;  // Reset image file when dialog opens

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!)
                        : currentImageUrl.isNotEmpty
                            ? NetworkImage(currentImageUrl) as ImageProvider
                            : AssetImage('assets/placeholder.png'), // Fallback placeholder
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(Icons.edit, color: Colors.white),
                      onPressed: _pickImage,  // Trigger image selection
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // TextField for editing name
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Product Name'),
                onChanged: (value) {
                currentName = value;
                },
              ),
              // TextField for editing price
             TextField(
  controller: priceController,
  decoration: InputDecoration(labelText: 'Product Price'),
  keyboardType: TextInputType.number,
  onChanged: (value) {
   currentPrice=(value);
  },
),


            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Call your update service to update product
                UpdateProductService().updateProduct(
                  productId,
                  currentName,
                  currentPrice,
                  _imageFile  // Pass the new image file if selected
                );
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  // Confirmation dialog for deleting a product
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
    ) ?? false;
  }
}
