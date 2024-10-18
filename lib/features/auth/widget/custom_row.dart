import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({
    super.key,
    this.onTap,
    required this.text,
    required this.text2,
  });

  final void Function()? onTap;
  final String text;
  final String text2;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text),
        InkWell(
            onTap: onTap,
            child: Text(
              text2,
              style: TextStyle(color: Color.fromARGB(255, 5, 99, 240)),
            ))
      ],
    );
  }
}
