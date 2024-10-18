import 'package:fashionapp/core/shared/bloc_observer/bloc_observer';
import 'package:fashionapp/core/shared/local_network.dart';
import 'package:fashionapp/features/auth/first/first_screen.dart';
import 'package:fashionapp/inmation.dart';
import 'package:fashionapp/layout/layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fashionapp/core/shared/constans/constans.dart';
import 'package:fashionapp/layout/layout_cubit/layout_cubit.dart';
import 'package:fashionapp/core/cubit/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheNetwork.cacheInitialization();
  token = await CacheNetwork.getCacheData(key: 'token');
  currentPassword = await CacheNetwork.getCacheData(key: 'password');
  debugPrint(" token is : $token");
  debugPrint(" current password is : $currentPassword");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
        BlocProvider<LayoutCubit>(
          create: (context) => LayoutCubit()
            ..getBannersData()
            ..getCategory()
            ..getUserData()
            ..getProductsData()
            ..getFavorites()
            ..getCarts(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:
            // InmationScreen()

            token != null && token!.isNotEmpty
                ? const LayoutScreen()
                : const FirstScreen(),
      ),
    );
  }
}
