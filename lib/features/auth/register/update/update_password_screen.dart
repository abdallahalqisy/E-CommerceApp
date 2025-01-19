import 'package:fashionapp/core/constants.dart';
import 'package:fashionapp/core/shared/constans/constans.dart';
import 'package:fashionapp/layout/layout_cubit/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordScreen extends StatelessWidget {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white,
                      child: Center(
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios)),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text(
                    'Create a new password',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Text(
                    'Your new password must be different\n from previous used passwords',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: currentPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Current Password',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: newPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'New Password',
                  ),
                ),
              ),
              const SizedBox(height: 50),
              BlocConsumer<LayoutCubit, LayoutState>(
                listener: (context, state) {
                  if (state is ChangePasswordSuccess) {
                    showSnackBarItem(
                        context, 'Password changed successfully', true);
                    Navigator.pop(context);
                  } else if (state is ChangePasswordFaild) {
                    showSnackBarItem(context, state.message, false);
                  }
                },
                builder: (context, state) {
                  return MaterialButton(
                    height: 50,
                    minWidth: 200,
                    splashColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.black,
                    onPressed: () {
                      if (currentPasswordController.text.trim() ==
                          currentPassword) {
                        if (newPasswordController.text.length >= 6) {
                          cubit.changePassword(
                              userCurrentPassword: currentPassword!,
                              newPassword: newPasswordController.text.trim());
                        } else {
                          showSnackBarItem(context,
                              'Password must be at least 6 characters ', false);
                        }
                      } else {
                        showSnackBarItem(
                            context,
                            'please verify current password , try again later ',
                            false);
                      }
                    },
                    child: Text(
                      state is ChangePasswordLoding ? 'Loading...' : 'Confirm',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void showSnackBarItem(
      BuildContext context, String message, bool forsuccorfailure) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: forsuccorfailure ? Colors.green : Colors.red,
      ),
    );
  }
}
