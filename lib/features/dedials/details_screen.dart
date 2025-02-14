import 'package:flutter/material.dart';

import '../../core/models/product_mode.dart';

class DetailsScreen extends StatelessWidget {
  final ProductModel model;

  const DetailsScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(model.name ?? 'No Name'), // عرض اسم المنتج
      ),
      body: Stack(children: [
        Positioned(
          left: 100,
          top: 620,
          child: Container(
            height: 50,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.favorite, color: Colors.black)),
                const SizedBox(width: 100),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add_shopping_cart, color: Colors.black)),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(
                    model.image ?? 'https://via.placeholder.com/200',
                    height: 200,
                    width: 200,
                    // fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  model.name ?? 'No Name',
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  "\$${model.price}",
                  style: const TextStyle(fontSize: 18, color: Colors.green),
                ),
                const SizedBox(height: 10),
                Text(
                  model.description ?? 'No Description',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
