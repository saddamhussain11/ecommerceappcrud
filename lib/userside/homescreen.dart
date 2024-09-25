import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final db = FirebaseFirestore.instance;

class addProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Screen"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 16),
          StreamBuilder(
            stream: db.collection('products').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error Loading Products'));
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text("No products available"));
              }

              final productList = snapshot.data!.docs;

              return Expanded(
                child: Column(
                  children: [
                    // Image Slider using PageView.builder with Image.network
                    Container(
                      height: 200, // Adjust the height as needed
                      child: PageView.builder(
                        itemCount: productList.length, // Number of items in the slider
                        itemBuilder: (context, index) {
                          final imageUrl = productList[index]["imageUrl"]; // Make sure this is correct
                          return imageUrl != null && imageUrl.isNotEmpty
                              ? Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.broken_image, size: 100); // Fallback in case of an error
                                  },
                                )
                              : Icon(Icons.broken_image, size: 100); // Fallback for missing URL
                        },
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns in the grid
                          crossAxisSpacing: 8, // Horizontal spacing between items
                          mainAxisSpacing: 8, // Vertical spacing between items
                          childAspectRatio: 0.75, // Adjust the aspect ratio to fit your design
                        ),
                        itemCount: productList.length,
                        itemBuilder: (context, index) {
                          // Extract product data
                          final product = productList[index];
                          final imageUrl = product["imageUrl"]; // Ensure correct Firestore field name
                
                          return Card(
                            elevation: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Check if imageUrl exists and is valid
                                imageUrl != null && imageUrl.isNotEmpty
                                    ? Image.network(
                                        imageUrl,
                                        width: double.infinity,
                                        height: 100,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Icon(Icons.broken_image, size: 100); // Fallback in case of an error
                                        },
                                      )
                                    : Icon(Icons.broken_image, size: 100), // Fallback for missing URL
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    product["name"] ?? "No Name",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    "\$${product['price'] ?? '0.00'}",
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
