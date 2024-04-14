import 'package:crud_demo/providers/product_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crud_demo/models/product_model.dart';
import 'package:crud_demo/widgets/text_field_widget.dart';

class EditProduct extends StatefulWidget {
  final Product? product;
  EditProduct({this.product});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final nameController = TextEditingController();

  final priceController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFieldWidget(
                controller: nameController,
                keyboardType: TextInputType.text,
                labelText: 'Product Name',
                onChanged: (value) {
                  productProvider.changeName = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Product Name';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFieldWidget(
                controller: priceController,
                keyboardType: TextInputType.number,
                labelText: 'Product Price',
                onChanged: (value) {
                  productProvider.changePrice = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Product Price';
                  } else if (!RegExp(r'^[0-9]+(\.[0-9]+)?$').hasMatch(value)) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await productProvider.saveProduct();
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Save'),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  widget.product == null
                      ? Container()
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
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
      ),
    );
  }
}
