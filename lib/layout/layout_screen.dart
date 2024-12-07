import 'package:fashionapp/core/constants.dart';
import 'package:fashionapp/features/customer_support/customer_service_screen.dart';
import 'package:fashionapp/layout/layout_cubit/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomerServiceScreen()));
                  },
                  icon: const Icon(Icons.support_agent)),
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: SvgPicture.asset(
                'assets/images/logo.svg',
                height: 50,
                color: mainColor,
              )),
          endDrawer: const Drawer(),
          bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: mainColor,
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.bottomNavIndex,
              onTap: (index) => {
                    cubit.changeBottomNavigationCurrentIndex(index: index),
                  },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.category), label: 'Category'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: 'Favorite'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart), label: 'Cart'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Profile'),
              ]),
          body: cubit.layoutScreens[cubit.bottomNavIndex],
        );
      },
    );
  }
}
