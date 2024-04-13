import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_demo/models/product_model.dart';
import 'package:crud_demo/services/firestore_services.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class ProductProvider with ChangeNotifier {
  final FireStoreServices _firestoreServices = FireStoreServices();
  String? _name;
  double? _price;
  String? _id;
  Timestamp? _createdAt;
  var uuid = Uuid();

  String? get name => _name;

  String? get price => _price?.toStringAsFixed(2);

  set changeName(String name) {
    _name = name;
    notifyListeners();
  }

  set changePrice(String price) {
    _price = double.parse(price);
    notifyListeners();
  }

  loadValues(Product product) {
    _name = product.name;
    _price = product.price;
    _id = product.id;
    _createdAt = product.createdAt;
  }

  saveProduct() async {
    if (_id == null) {
      // New product
      await _firestoreServices.saveProduct(
        Product(
          id: uuid.v4(),
          name: _name,
          price: _price,
          createdAt: Timestamp.now(),
          updatedAt: Timestamp.now(),
        ),
      );
    } else {
      // Update product
      await _firestoreServices.saveProduct(
        Product(
          id: _id.toString(),
          name: _name,
          price: _price,
          createdAt: _createdAt,
          updatedAt: Timestamp.now(),
        ),
      );
    }
  }

  deleteProduct() async {
    await _firestoreServices.deleteProduct(_id!);
  }
}
