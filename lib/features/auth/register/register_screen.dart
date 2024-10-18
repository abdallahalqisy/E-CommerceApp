import 'package:fashionapp/core/constants.dart';
import 'package:fashionapp/core/cubit/auth_cubit.dart';
import 'package:fashionapp/features/auth/login/login_screen.dart';
import 'package:fashionapp/features/auth/register/widget/custom_text_form_field.dart';
import 'package:fashionapp/features/auth/widget/custom_row.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
        } else if (state is FailedToRegisterState) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(
                    state.message,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.red,
                );
              });
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 150),
                  const Text('Sign Up',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: formkey,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            validator: (input) {
                              if (nameController.text.isEmpty) {
                                return 'Name must not be empty';
                              }
                              return null;
                            },
                            controller: nameController,
                            hintText: 'Name',
                            icon: Icons.person,
                          ),
                          CustomTextFormField(
                            validator: (input) {
                              if (emailController.text.isEmpty) {
                                return 'Email must not be empty';
                              }
                              return null;
                            },
                            controller: emailController,
                            hintText: 'Email',
                            icon: Icons.email,
                          ),
                          CustomTextFormField(
                            validator: (input) {
                              if (phoneController.text.isEmpty) {
                                return 'Phone must not be empty';
                              }
                              return null;
                            },
                            controller: phoneController,
                            hintText: 'Phone',
                            icon: Icons.phone,
                            isPhoneField: true, // تحديد أنه حقل هاتف
                          ),
                          CustomTextFormField(
                            validator: (input) {
                              if (passwordController.text.isEmpty) {
                                return 'Password must not be empty';
                              }
                              return null;
                            },
                            controller: passwordController,
                            hintText: 'Password',
                            icon: Icons.lock,
                            isSecure: true,
                          ),
                          MaterialButton(
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                BlocProvider.of<AuthCubit>(context).register(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: mainColor,
                            textColor: Colors.white,
                            minWidth: double.infinity,
                            child: Text(
                              state is RegisterLoadingState
                                  ? 'Loading.....'
                                  : 'Register',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomRow(
                            text2: '  Login',
                            text: 'Already have an account?',
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
