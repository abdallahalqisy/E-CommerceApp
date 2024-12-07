import 'package:fashionapp/layout/layout_cubit/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tawkto/flutter_tawk.dart';

class CustomerServiceScreen extends StatelessWidget {
  const CustomerServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff7d998a),
        centerTitle: true,
        title: const Text(
          'Customer Service',
        ),
      ),
      body: Tawk(
        directChatLink:
            'https://tawk.to/chat/675492ee2480f5b4f5a9cc9e/1ieh5s1v6',
        visitor: TawkVisitor(
          name: cubit.userModel!.name,
          email: cubit.userModel!.email,
        ),
        onLoad: () {
          print('Hello Tawk!');
        },
        onLinkTap: (String url) {
          print(url);
        },
        placeholder: const Center(
          child: Text('Loading...'),
        ),
      ),
    );
  }
}
