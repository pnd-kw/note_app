import 'package:flutter/material.dart';

class NotesTextField extends StatelessWidget {
  const NotesTextField({
    super.key,
    this.controller,
    this.validator,
    this.labelText,
    this.minLines,
    this.maxLines,
  });

  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final String? labelText;
  final int? minLines;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      minLines: minLines,
      maxLines: maxLines,
    );
  }
}
