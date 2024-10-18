import 'package:fashionapp/core/constants.dart';
import 'package:fashionapp/features/auth/register/update/update_password_screen.dart';
import 'package:fashionapp/features/auth/register/update/update_profile_data_screen.dart';
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
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: SvgPicture.asset(
                'assets/images/logo.svg',
                height: 50,
                color: mainColor,
              )),
          endDrawer: const Drawer(
              // child: ListView(
              //   children: [
              //     DrawerHeader(
              //       decoration: const BoxDecoration(
              //         color: mainColor,
              //       ),
              //       child: Column(
              //         children: [
              //           CircleAvatar(
              //             radius: 25,
              //             backgroundImage: cubit.userModel!.image != null
              //                 ? NetworkImage(cubit.userModel!.image!)
              //                 : null,
              //           ),

              //           const SizedBox(height: 10),
              //           Text(
              //             cubit.userModel!.name!,
              //             style: const TextStyle(
              //                 color: Colors.white,
              //                 fontSize: 20,
              //                 fontWeight: FontWeight.bold),
              //           ),
              //           const SizedBox(height: 5),
              //           Text(
              //             cubit.userModel!.email!,
              //             style: const TextStyle(
              //                 color: Colors.white,
              //                 fontSize: 15,
              //                 fontWeight: FontWeight.bold),
              //           ),
              //         ],
              //       ),
              //     ),
              //     ListTile(
              //       leading: const Icon(Icons.person),
              //       title: const Text('Update Profile'),
              //       onTap: () {
              //         Navigator.of(context).push(
              //           MaterialPageRoute(
              //             builder: (context) => UpdateProfileDataScreen(),
              //           ),
              //         );
              //       },
              //     ),
              //     ListTile(
              //       leading: const Icon(Icons.lock),
              //       title: const Text('Update Password'),
              //       onTap: () {
              //         Navigator.of(context).push(
              //           MaterialPageRoute(
              //             builder: (context) => ChangePasswordScreen(),
              //           ),
              //         );
              //       },
              //     ),
              //     ListTile(
              //       leading: const Icon(Icons.logout),
              //       title: const Text(
              //         'Logout',
              //         style: TextStyle(
              //             color: Colors.red, fontWeight: FontWeight.bold),
              //       ),
              //       onTap: () {
              //         cubit.logout();
              //       },
              //     ),
              //   ],
              // ),

              ),
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
