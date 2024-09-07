import 'package:flutter/material.dart';

class Product {
  final String name;
  final String price;
  final String imagePath;

  Product({required this.name, required this.price, required this.imagePath});
}

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  // Sample list of products
  List<Product> productList = [
    Product(name: "Product 1", price: "10.00", imagePath: "assets/image/download (3).jpeg"),
    Product(name: "Product 2", price: "20.00", imagePath: "assets/image/download (3).jpeg"),
    Product(name: "Product 3", price: "30.00", imagePath: "assets/image/download (3).jpeg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) {
          final product = productList[index];

          return ListTile(
            leading: Image.asset(
              product.imagePath, // Display product image
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(product.name),
            subtitle: Text("\$${product.price}"), // Display product price
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue), // Edit Icon
                  onPressed: () {
                    // Placeholder for edit action
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red), // Delete Icon
                  onPressed: () {
                    // Placeholder for delete action
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}


