import 'package:crud_demo/models/product_model.dart';
import 'package:crud_demo/services/firestore_services.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class ProductProvider with ChangeNotifier {
  final FireStoreServices _firestoreServices = FireStoreServices();
  late String _name;
  late double _price;
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

  saveProduct() async {
    Product newProduct = Product(
      id: uuid.v4(),
      name: _name,
      price: _price,
    );
    await _firestoreServices.saveProduct(newProduct);
  }
}
