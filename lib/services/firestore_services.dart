import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_demo/models/product_model.dart';

class FireStoreServices {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future saveProduct(Product product) async {
    await _db.collection('products').doc(product.id).set(product.toMap());
  }

  Stream<QuerySnapshot> getProducts() {
    return _db.collection('products').snapshots();
  }
}
