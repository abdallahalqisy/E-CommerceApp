import 'package:fashionapp/layout/layout_cubit/layout_cubit.dart';
import 'package:flutter/material.dart';

class textFormField extends StatelessWidget {
  const textFormField({
    super.key,
    required this.cubit,
  });
  final LayoutCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextFormField(
        onChanged: (input) {
          cubit.filterProducts(input: input);
        },
        decoration: InputDecoration(
          fillColor: Colors.grey.withOpacity(0.1),
          filled: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          suffixIcon: const Icon(Icons.clear),
          hintText: 'Search',
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}
