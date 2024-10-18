import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    required this.hintText,
    required this.icon,
    this.controller,
    this.validator,
    this.isSecure,
    this.isPhoneField = false,
  });

  bool? isSecure;
  final String hintText;
  final IconData icon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool isPhoneField; // علم يحدد إذا كان الحقل للهاتف

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        obscureText: isSecure ?? false,
        validator: validator,
        controller: controller,
        keyboardType: isPhoneField
            ? TextInputType.number
            : TextInputType.text, // تغيير نوع لوحة المفاتيح
        inputFormatters: isPhoneField
            ? [
                FilteringTextInputFormatter.digitsOnly
              ] // السماح بإدخال الأرقام فقط
            : [],
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hintText,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}
