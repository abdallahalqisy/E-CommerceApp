import 'package:fashionapp/core/models/product_mode.dart';
import 'package:fashionapp/features/dedials/details_screen.dart';
import 'package:fashionapp/layout/layout_cubit/layout_cubit.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final ProductModel model;
  final LayoutCubit cubit;
  ProductItem({super.key, required this.model, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        color: Colors.grey.withOpacity(.2),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (model.image != null)
              Expanded(
                child: Center(
                    child: Image.network(
                  model.image!,
                  fit: BoxFit.fill,
                )),
              ),
            const SizedBox(height: 10),
            if (model.name != null)
              Text(
                model.name!,
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            const SizedBox(height: 10),
            Row(children: [
              if (model.price != null)
                Expanded(
                  child: Text(
                    '${model.price!}\$',
                  ),
                ),
              const SizedBox(width: 10),
              if (model.oldPrice != null)
                Text(
                  '${model.oldPrice!}\$',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              GestureDetector(
                child: Icon(
                  Icons.favorite,
                  size: 20,
                  color: cubit.favoritesIds.contains(model.id.toString())
                      ? Colors.red
                      : Colors.grey,
                ),
                onTap: () {
                  cubit.addOrRemoveFavorite(productId: model.id.toString());
                },
              )
            ])
          ],
        ),
      ),
      CircleAvatar(
        backgroundColor: cubit.cartsId.contains(model.id.toString())
            ? Colors.red
            : Colors.white,
        child: IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.black,
          ),
          onPressed: () {
            cubit.addOrRemoveItemFromCart(productId: model.id.toString());
          },
        ),
      )
    ]);
  }
}
