import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String? id;
  final String? name;
  final double? price;
  final Timestamp? createdAt;
  final Timestamp? updatedAt;

  Product({this.id, this.name, this.price, this.createdAt, this.updatedAt});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
