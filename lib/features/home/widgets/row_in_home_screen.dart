import 'package:fashionapp/core/constants.dart';
import 'package:fashionapp/features/cetagory/cetagory_screen.dart';
import 'package:flutter/material.dart';

class RowInHomeView extends StatelessWidget {
  final String text;
  const RowInHomeView({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: mainColor)),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CetagoryScreen(),
              ),
            );
          },
          child: const Text('View All',
              style: TextStyle(
                  // fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: secondaryColor)),
        )
      ],
    );
  }
}
