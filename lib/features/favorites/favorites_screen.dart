import 'package:fashionapp/core/constants.dart';
import 'package:fashionapp/layout/layout_cubit/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 12.5),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                      ),
                      hintText: 'Search',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: cubit.favorites.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 12.5),
                              margin: const EdgeInsets.only(bottom: 10),
                              height: 150,
                              color: fourColor,
                              child: Row(
                                children: [
                                  Image.network(
                                    cubit.favorites[index].image!,
                                    width: 120,
                                    height: 100,
                                    fit: BoxFit.fill,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          cubit.favorites[index].name!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style:
                                              const TextStyle(color: mainColor),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            ' Price: ${cubit.favorites[index].price ?? 'N/A'}\$'),
                                        MaterialButton(
                                          onPressed: () {
                                            cubit.addOrRemoveFavorite(
                                                productId: cubit
                                                    .favorites[index].id
                                                    .toString());
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          color: mainColor,
                                          textColor: Colors.white,
                                          child: const Text('Remove'),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }))
                ],
              )),
        );
      },
    );
  }
}
