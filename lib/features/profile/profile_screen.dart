import 'package:fashionapp/core/constants.dart';
import 'package:fashionapp/core/shared/constans/constans.dart';
import 'package:fashionapp/features/auth/first/first_screen.dart';
import 'package:fashionapp/features/auth/register/update/update_password_screen.dart';
import 'package:fashionapp/features/auth/register/update/update_profile_data_screen.dart';
import 'package:fashionapp/layout/layout_cubit/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = BlocProvider.of<LayoutCubit>(context);
        return Scaffold(
          // appBar: AppBar(
          //   automaticallyImplyLeading: false,
          //   actions: [
          //     BlocConsumer<LayoutCubit, LayoutState>(
          //       listener: (context, state) {
          //         if (state is LogoutSuccessState) {
          //           Navigator.of(context).pushReplacement(
          //             MaterialPageRoute(
          //               builder: (context) => const FirstScreen(),
          //             ),
          //           );
          //           debugPrint(token);
          //         }
          //       },
          //       builder: (context, state) {
          //         return IconButton(
          //           onPressed: () {
          //             cubit.logout();
          //           },
          //           icon: const Icon(
          //             Icons.logout_sharp,
          //             color: Colors.red,
          //           ),
          //         );
          //       },
          //     ),
          //   ],
          // ),
          body: cubit.userModel != null
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: cubit.userModel!.image != null
                            ? NetworkImage(cubit.userModel!.image!)
                            : null,
                      ),
                      const SizedBox(height: 50),
                      Row(
                        children: [
                          const Icon(
                            Icons.person,
                            size: 25,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            cubit.userModel!.name!,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey, // لون الخط
                        thickness: 1,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(
                            Icons.email,
                            size: 25,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            cubit.userModel!.email!,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(
                            Icons.phone,
                            size: 25,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            cubit.userModel?.phone ?? '',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MaterialButton(
                            height: 50,
                            minWidth: 150,
                            splashColor: secondaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: Colors.black,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ChangePasswordScreen(
                                    // userModel: cubit.userModel,
                                    ),
                              ));
                            },
                            child: const Text(
                              'Change Password',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 20),
                          MaterialButton(
                            height: 50,
                            minWidth: 150,
                            splashColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UpdateProfileDataScreen(),
                              ));
                            },
                            child: const Text(
                              'Update Profile',
                              style: TextStyle(color: mainColor),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
