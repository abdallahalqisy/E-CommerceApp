import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:fashionapp/core/shared/constans/constans.dart';
import 'package:fashionapp/core/shared/local_network.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    emit(RegisterLoadingState());
    Response response = await http.post(
        Uri.parse('https://student.valuxapps.com/api/register'),
        headers: {
          'lang': 'en',
        },
        body: {
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
        });
    // responseعشان افك التشفير بتاع ال
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      print(responseBody);

      emit(RegisterSuccessState());
    } else {
      print(responseBody);
      emit(FailedToRegisterState(message: responseBody['message']));
    }
  }

  void login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    try {
      Response response = await http.post(
          Uri.parse('https://student.valuxapps.com/api/login'),
          headers: {},
          body: {
            'email': email,
            'password': password,
          });

      if (response.statusCode == 200) {
        var date = jsonDecode(response.body);
        if (date['status'] == true) {
          await CacheNetwork.insertToCache(
              key: "token", value: date['data']['token']);
          await CacheNetwork.insertToCache(key: "password", value: password);
          token = await CacheNetwork.getCacheData(key: 'token');
          currentPassword = await CacheNetwork.getCacheData(key: 'password');

          emit(LoginSuccessState());
        } else {
          debugPrint('Failed to login, reason is  :${date['message']}');
          emit(FailedToLoginState(message: date['message']));
        }
      }
    } on Exception catch (e) {
      emit(FailedToLoginState(message: e.toString()));
    }
  }
}
