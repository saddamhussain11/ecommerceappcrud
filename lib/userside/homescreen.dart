import 'package:flutter/material.dart';

class Product {
  final String name;
  final String price;
  final String imagePath;

  Product({required this.name, required this.price, required this.imagePath});
}

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Sample list of products
    List<Product> productList = [
      Product(name: "Product 1", price: "10.00", imagePath: "assets/image/download (6).jpeg"),
      Product(name: "Product 2", price: "20.00", imagePath: "assets/image/download (6).jpeg"),
      Product(name: "Product 3", price: "30.00", imagePath: "assets/image/download (6).jpeg"),
      // Add more products if needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Product Screen"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Image Slider
          Container(
            height: 200, // Adjust the height as needed
            child: PageView(
              children: [
                Image.asset('assets/image/download (3).jpeg', fit: BoxFit.cover),
                Image.asset('assets/image/download (3).jpeg', fit: BoxFit.cover),
                Image.asset('assets/image/download (3).jpeg', fit: BoxFit.cover),
              ],
            ),
          ),
          SizedBox(height: 16), // Space between slider and grid

          // GridView of Products
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
                final product = productList[index];
                return Card(
                  elevation: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        product.imagePath,
                        width: double.infinity,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          product.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "\$${product.price}",
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
  }
}

