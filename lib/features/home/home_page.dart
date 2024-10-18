import 'package:fashionapp/features/home/widgets/banners.dart';
import 'package:fashionapp/features/home/widgets/product_item.dart';
import 'package:fashionapp/features/home/widgets/row_in_home_screen.dart';
import 'package:fashionapp/layout/layout_cubit/layout_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final pageController = PageController();
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(12),
            child: ListView(
              shrinkWrap: true,
              children: [
                CustomBanners(cubit: cubit, pageController: pageController),
                const SizedBox(
                  height: 10,
                ),
                const RowInHomeView(
                  text: 'Products',
                ),
                cubit.product.isEmpty
                    ? const Center(
                        child: CupertinoActivityIndicator(),
                      )
                    : GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cubit.filteredProducts.isEmpty
                            ? cubit.product.length
                            : cubit.filteredProducts.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.7,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return ProductItem(
                              cubit: cubit,
                              model: cubit.filteredProducts.isEmpty
                                  ? cubit.product[index]
                                  : cubit.filteredProducts[index]);
                        },
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
