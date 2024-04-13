import 'package:crud_demo/providers/product_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crud_demo/models/product_model.dart';

class EditProduct extends StatefulWidget {
  final Product? product;
  EditProduct({this.product});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final nameController = TextEditingController();

  final priceController = TextEditingController();

  @override
  void initState() {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    if (widget.product != null) {
      nameController.text = widget.product!.name!;
      priceController.text = widget.product!.price!.toStringAsFixed(2);
      productProvider.loadValues(widget.product!);
    } else {
      nameController.text = "";
      priceController.text = "";
      productProvider.loadValues(Product());
    }

    super.initState();
  }

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
              controller: nameController,
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
              controller: priceController,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await productProvider.saveProduct();
                    Navigator.of(context).pop();
                  },
                  child: Text('Save'),
                ),
                SizedBox(
                  width: 10.0,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    productProvider.deleteProduct();
                    Navigator.of(context).pop();
                  },
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
