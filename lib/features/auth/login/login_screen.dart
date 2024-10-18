import 'package:fashionapp/core/constants.dart';
import 'package:fashionapp/core/cubit/auth_cubit.dart';
import 'package:fashionapp/features/auth/register/widget/custom_text_form_field.dart';
import 'package:fashionapp/features/auth/widget/custom_row.dart';
import 'package:fashionapp/layout/layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/auth_background.png'),
                fit: BoxFit.fill)),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LayoutScreen(),
                ),
              );
            }
            if (state is FailedToLoginState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Container(
                      alignment: Alignment.center, child: Text(state.message)),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 30),
                      alignment: Alignment.bottomCenter,
                      child: const Text(
                        'Login To Continue Process',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: thirdColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: Form(
                        key: formKey,
                        child: BlocConsumer<AuthCubit, AuthState>(
                          listener: (context, state) {},
                          builder: (context, state) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Login',
                                style: TextStyle(
                                    color: mainColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomTextFormField(
                                controller: emailController,
                                hintText: 'Email',
                                icon: Icons.email,
                                validator: (input) {
                                  if (emailController.text.isEmpty) {
                                    return 'Email must not be empty';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              CustomTextFormField(
                                isSecure: true,
                                controller: passwordController,
                                hintText: 'Password',
                                icon: Icons.lock,
                                validator: (input) {
                                  if (passwordController.text.isNotEmpty) {
                                    return null;
                                  } else {
                                    return 'Password must not be empty';
                                  }
                                },
                              ),
                              MaterialButton(
                                onPressed: () {
                                  // ignore: unrelated_type_equality_checks
                                  if (formKey.currentState!.validate()) {
                                    BlocProvider.of<AuthCubit>(context).login(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                minWidth: double.infinity,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: mainColor,
                                child: Text(
                                  state is LoginLoadingState
                                      ? 'Loading....'
                                      : 'Login',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const CustomRow(
                                  text: 'Forget your password?',
                                  text2: '  Click Here')
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
