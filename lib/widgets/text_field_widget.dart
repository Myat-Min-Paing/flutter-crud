import 'package:flutter/material.dart';
import 'package:crud_demo/constant.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.controller,
    this.keyboardType,
    required this.labelText,
    required this.onChanged,
    this.validator,
  });

  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String labelText;
  final Function(String) onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: kTextFiedDecoration.copyWith(
        labelText: labelText,
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
