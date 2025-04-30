import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final int maxLines;
  final Function(String?)? onSave;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    this.hint = '',
    this.maxLines = 1,
    this.onSave,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: TextFormField(
        controller: controller, // 👈 هنا خلاص بتاخد controller جاهز من بره
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        onSaved: onSave,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.cyan,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
          filled: true,
          fillColor: Colors.white.withOpacity(0.1),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.cyan, width: 1.8),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
        ),
      ),
    );
  }
}
