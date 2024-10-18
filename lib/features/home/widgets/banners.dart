import 'package:fashionapp/core/constants.dart';
import 'package:fashionapp/features/home/widgets/row_in_home_screen.dart';
import 'package:fashionapp/features/home/widgets/text_form_faild.dart';
import 'package:fashionapp/layout/layout_cubit/layout_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomBanners extends StatelessWidget {
  const CustomBanners({
    super.key,
    required this.cubit,
    required this.pageController,
  });

  final LayoutCubit cubit;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        textFormField(cubit: cubit),
        cubit.banners.isEmpty
            ? const Center(child: CupertinoActivityIndicator())
            : SizedBox(
                height: 125,
                width: double.infinity,
                child: PageView.builder(
                    controller: pageController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: cubit.banners.length,
                    itemBuilder: (context, index) {
                      // ignore: avoid_unnecessary_containers
                      return Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: Image.network(
                          cubit.banners[index].url!,
                          fit: BoxFit.fill,
                        ),
                      );
                    }),
              ),
        const SizedBox(
          height: 15,
        ),
        Center(
          child: SmoothPageIndicator(
            controller: pageController,
            count: cubit.banners.length,
            axisDirection: Axis.horizontal,
            effect: const SlideEffect(
                spacing: 8.0,
                radius: 25,
                dotWidth: 16,
                dotHeight: 16.0,
                paintStyle: PaintingStyle.stroke,
                strokeWidth: 1.5,
                dotColor: Colors.grey,
                activeDotColor: secondaryColor),
          ),
        ),
        const SizedBox(height: 15),
        const RowInHomeView(
          text: 'Categories',
        ),
        cubit.categories.isEmpty
            ? const Center(child: CupertinoActivityIndicator())
            : SizedBox(
                height: 70,
                width: double.infinity,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: cubit.categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      // ignore: avoid_unnecessary_containers
                      return Padding(
                        padding: const EdgeInsets.only(top: 10.0, right: 10.0),
                        child: CircleAvatar(
                          radius: 45,
                          backgroundImage: NetworkImage(
                            cubit.categories[index].url!,
                          ),
                        ),
                      );
                    }),
              ),
      ],
    );
  }
}
