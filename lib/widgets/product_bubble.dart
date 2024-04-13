import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:crud_demo/models/product_model.dart';
import 'package:crud_demo/screens/edit_product.dart';

class ProductBubble extends StatelessWidget {
  const ProductBubble(
      {super.key,
      required this.productId,
      required this.productName,
      required this.price,
      required this.createdAt});
  final String productId;
  final String productName;
  final String price;
  final Timestamp createdAt;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EditProduct(
              product: Product(
                id: productId,
                name: productName,
                price: double.parse(price),
                createdAt: createdAt,
              ),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey.shade300,
        ),
        padding: EdgeInsets.all(20.0),
        margin: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              productName,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
              ),
            ),
            Text(
              "\$${price}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
