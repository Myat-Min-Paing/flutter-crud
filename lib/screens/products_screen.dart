import 'package:flutter/material.dart';
import 'package:crud_demo/screens/edit_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_demo/services/firestore_services.dart';
import 'package:crud_demo/widgets/product_bubble.dart';

class Products extends StatelessWidget {
  Products({super.key});
  final _fireStoreServices = FireStoreServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => EditProduct()));
            },
          )
        ],
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: _fireStoreServices.getProducts(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final products = snapshot.data!.docs;
              List<ProductBubble> productBubbleWidgets = [];
              for (var product in products) {
                final productName = product.get('name');
                final productPrice = product.get('price');
                final productBubbleWidget = ProductBubble(
                  productId: product.id,
                  productName: productName,
                  price: productPrice.toString(),
                );
                productBubbleWidgets.add(productBubbleWidget);
              }
              return Expanded(
                child: ListView(
                  children: productBubbleWidgets,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
