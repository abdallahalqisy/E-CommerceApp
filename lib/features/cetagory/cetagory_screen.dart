import 'package:fashionapp/core/models/category_model.dart';
import 'package:fashionapp/layout/layout_cubit/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CetagoryScreen extends StatelessWidget {
  const CetagoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categoryData =
        BlocProvider.of<LayoutCubit>(context).categories;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: GridView.builder(
          itemCount: categoryData.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 1,
            crossAxisSpacing: 10,
            childAspectRatio: .9,
          ),
          itemBuilder: (context, index) {
            return Container(
              child: Column(
                children: [
                  Image.network(
                    fit: BoxFit.fill,
                    categoryData[index].url!,
                    height: 150,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    categoryData[index].title!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
