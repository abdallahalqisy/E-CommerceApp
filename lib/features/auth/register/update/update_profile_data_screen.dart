// import 'package:fashionapp/core/constants.dart';
// import 'package:fashionapp/layout/layout_cubit/layout_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class UpdateProfileDataScreen extends StatefulWidget {
//   const UpdateProfileDataScreen({super.key});

//   @override
//   _UpdateProfileDataScreenState createState() =>
//       _UpdateProfileDataScreenState();
// }

// class _UpdateProfileDataScreenState extends State<UpdateProfileDataScreen> {
//   final nameController = TextEditingController();
//   final phoneController = TextEditingController();
//   final emailController = TextEditingController();
//   File? _image;

//   @override
//   void initState() {
//     super.initState();
//     final cubit = BlocProvider.of<LayoutCubit>(context);
//     nameController.text = cubit.userModel!.name!;
//     emailController.text = cubit.userModel!.email!;
//     phoneController.text = cubit.userModel!.phone!;
//   }

//   Future<void> _pickImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cubit = BlocProvider.of<LayoutCubit>(context);

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: mainColor,
//         centerTitle: true,
//         title: const Text(
//           'Update Profile',
//           style: TextStyle(color: fourColor, fontWeight: FontWeight.w900),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 CircleAvatar(
//                   radius: 50,
//                   backgroundImage: _image != null
//                       ? FileImage(_image!)
//                       : cubit.userModel!.image != null
//                           ? NetworkImage(cubit.userModel!.image!)
//                               as ImageProvider
//                           : null,
//                 ),
//                 Positioned(
//                   bottom: 0,
//                   right: 0,
//                   child: IconButton(
//                     icon: Icon(Icons.camera_alt, color: mainColor),
//                     onPressed: _pickImage,
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10),
//               child: TextFormField(
//                 controller: nameController,
//                 decoration: const InputDecoration(
//                   labelText: 'User Name',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10),
//               child: TextFormField(
//                 controller: emailController,
//                 decoration: const InputDecoration(
//                   labelText: 'Email',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10),
//               child: TextFormField(
//                 controller: phoneController,
//                 decoration: const InputDecoration(
//                   labelText: 'Phone',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             BlocConsumer<LayoutCubit, LayoutState>(
//               listener: (context, state) {
//                 if (state is UpdateUserDataSuccess) {
//                   showSnackBarItem(
//                       context, 'Profile updated successfully', true);
//                   Navigator.pop(context);
//                 }
//                 if (state is UpdateUserDatafailyer) {
//                   showSnackBarItem(context, state.message, false);
//                 }
//               },
//               builder: (context, state) {
//                 return MaterialButton(
//                   height: 50,
//                   minWidth: double.infinity,
//                   splashColor: mainColor,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   color: fourColor,
//                   onPressed: () {
//                     if (nameController.text.isNotEmpty &&
//                         emailController.text.isNotEmpty &&
//                         phoneController.text.isNotEmpty) {
//                       cubit.updateUserData(
//                         name: nameController.text,
//                         email: emailController.text,
//                         phone: phoneController.text,
//                         image: _image,
//                       );
//                     } else {
//                       showSnackBarItem(
//                           context, 'Please enter all fields', false);
//                     }
//                   },
//                   child: Text(
//                     state is UpdateUserDataLoading ? 'Loading...' : 'Update ',
//                     style: TextStyle(color: mainColor),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void showSnackBarItem(
//       BuildContext context, String message, bool forsuccorfailure) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: forsuccorfailure ? Colors.green : Colors.red,
//       ),
//     );
//   }
// }
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
      appBar: AppBar(
        backgroundColor: mainColor,
        centerTitle: true,
        title: const Text(
          'Update Profile',
          style: TextStyle(color: fourColor, fontWeight: FontWeight.w900),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 20),
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
                    minWidth: double.infinity,
                    splashColor: mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: fourColor,
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
                      state is UpdateUserDataLoading ? 'Loading...' : 'Update ',
                      style: TextStyle(color: mainColor),
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
