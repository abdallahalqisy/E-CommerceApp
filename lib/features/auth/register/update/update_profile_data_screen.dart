import 'package:fashionapp/core/constants.dart';
import 'package:fashionapp/layout/layout_cubit/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateProfileDataScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  UpdateProfileDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    nameController.text =
        BlocProvider.of<LayoutCubit>(context).userModel!.name!;
    emailController.text =
        BlocProvider.of<LayoutCubit>(context).userModel!.email!;
    phoneController.text =
        BlocProvider.of<LayoutCubit>(context).userModel!.phone!;
    final cubit = BlocProvider.of<LayoutCubit>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
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
                    ),
                    const SizedBox(width: 50),
                    const Text('Profile Settings',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              CircleAvatar(
                radius: 50,
                backgroundImage: cubit.userModel!.image != null
                    ? NetworkImage(cubit.userModel!.image!)
                    : null,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'User Name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                  ),
                ),
              ),
              SizedBox(height: 40),
              BlocConsumer<LayoutCubit, LayoutState>(
                listener: (context, state) {
                  if (state is UpdateUserDataSuccess) {
                    showSnackBarItem(
                        context, 'Profile updated successfully', true);
                    Navigator.pop(context);
                  }
                  if (state is UpdateUserDatafailyer) {
                    showSnackBarItem(context, state.message, false);
                  }
                },
                builder: (context, state) {
                  return MaterialButton(
                    height: 50,
                    minWidth: 200,
                    splashColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    color: Colors.black,
                    onPressed: () {
                      if (nameController.text.isNotEmpty &&
                          emailController.text.isNotEmpty &&
                          phoneController.text.isNotEmpty) {
                        cubit.updateUserData(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                        );
                      } else {
                        showSnackBarItem(
                            context, 'Please enter all fields', false);
                      }
                    },
                    child: Text(
                      state is UpdateUserDataLoading
                          ? 'Loading...'
                          : 'Save Changes ',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
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
