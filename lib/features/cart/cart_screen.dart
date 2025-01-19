import 'package:fashionapp/core/constants.dart';
import 'package:fashionapp/layout/layout_cubit/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = BlocProvider.of<LayoutCubit>(context);
        return Scaffold(
            body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              const SizedBox(
                height: 12.5,
              ),
              Expanded(
                  child: cubit.carts.isNotEmpty
                      ? ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 12.5,
                          ),
                          itemCount: cubit.carts.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              key: Key(cubit.carts[index].id
                                  .toString()), // Use a unique identifier for each item
                              direction: DismissDirection
                                  .endToStart, // السحب من اليمين إلى اليسار
                              onDismissed: (direction) {
                                cubit.addOrRemoveItemFromCart(
                                    productId:
                                        cubit.carts[index].id.toString());
                              },
                              background: Container(
                                color: mainColor,
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: const Icon(Icons.delete,
                                    color: Colors.white),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  height: 130,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: fourColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Image.network(
                                          cubit.carts[index].image!,
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.fill,
                                        ),
                                        const SizedBox(
                                          width: 12.5,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                cubit.carts[index].name!,
                                                style: const TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Text(cubit.carts[index].price
                                                      .toString()),
                                                  const SizedBox(
                                                    width: 30,
                                                  ),
                                                  if (cubit
                                                          .carts[index].price !=
                                                      cubit.carts[index]
                                                          .oldPrice)
                                                    Text(
                                                      cubit.carts[index]
                                                          .oldPrice!
                                                          .toString(),
                                                      style: const TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                      ),
                                                    ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  OutlinedButton(
                                                    onPressed: () {
                                                      cubit.addOrRemoveFavorite(
                                                          productId: cubit
                                                              .carts[index].id
                                                              .toString());
                                                    },
                                                    child: Icon(
                                                      Icons.favorite,
                                                      color: cubit.favoritesIds
                                                              .contains(cubit
                                                                  .carts[index]
                                                                  .id
                                                                  .toString())
                                                          ? Colors.grey
                                                          : Colors.red,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      cubit
                                                          .addOrRemoveItemFromCart(
                                                              productId: cubit
                                                                  .carts[index]
                                                                  .id
                                                                  .toString());
                                                    },
                                                    child: const Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text('LOADING...'),
                        )),
              GestureDetector(
                onTap: () {},
                child: Container(
                  color: thirdColor,
                  height: 60,
                  child: Center(
                    child: Text(
                      'Total Price :${cubit.totalPrice}\$',
                      style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                          color: mainColor),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
      },
    );
  }
}
