import 'package:crud_demo/models/product_model.dart';
import 'package:crud_demo/services/firestore_services.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class ProductProvider with ChangeNotifier {
  final FireStoreServices _firestoreServices = FireStoreServices();
  late String _name;
  late double _price;
  String? _id;
  var uuid = Uuid();

  String get name => _name;

  String get price => _price.toStringAsFixed(2);

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
  }

  saveProduct() async {
    if (_id == null) {
      await _firestoreServices.saveProduct(
        Product(
          id: uuid.v4(),
          name: _name,
          price: _price,
        ),
      );
    } else {
      await _firestoreServices.saveProduct(
        Product(
          id: _id.toString(),
          name: _name,
          price: _price,
        ),
      );
    }
  }

  deleteProduct() async {
    await _firestoreServices.deleteProduct(_id!);
  }
}
