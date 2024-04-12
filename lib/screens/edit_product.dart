import 'package:crud_demo/providers/product_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProduct extends StatelessWidget {
  const EditProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                  labelText: 'Product Name',
                  floatingLabelAlignment: FloatingLabelAlignment.center),
              onChanged: (value) {
                productProvider.changeName = value;
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Product Price',
                floatingLabelAlignment: FloatingLabelAlignment.center,
              ),
              onChanged: (value) {
                productProvider.changePrice = value;
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
                onPressed: () async {
                  await productProvider.saveProduct();
                  Navigator.of(context).pop();
                },
                child: Text('Save')),
          ],
        ),
      ),
    );
  }
}
