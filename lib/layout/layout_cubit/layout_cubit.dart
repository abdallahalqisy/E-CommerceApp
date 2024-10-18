import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:fashionapp/core/models/banner_model.dart';
import 'package:fashionapp/core/models/category_model.dart';
import 'package:fashionapp/core/models/product_mode.dart';
import 'package:fashionapp/core/models/user_model.dart';
import 'package:fashionapp/core/shared/constans/constans.dart';
import 'package:fashionapp/core/shared/local_network.dart';
import 'package:fashionapp/features/cart/cart_screen.dart';
import 'package:fashionapp/features/cetagory/cetagory_screen.dart';
import 'package:fashionapp/features/favorites/favorites_screen.dart';
import 'package:fashionapp/features/home/home_page.dart';
import 'package:fashionapp/features/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());
  int bottomNavIndex = 0;
  List<Widget> layoutScreens = [
    HomeScreen(),
    const CetagoryScreen(),
    const FavoritesScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];
  void changeBottomNavigationCurrentIndex({required int index}) {
    bottomNavIndex = index;
    emit(ChangeBottomNavigationCurrentIndexState());
  }

  UserModel? userModel;
  Future<void> getUserData() async {
    emit(GetUserDataLodingState());
    Response response = await http.get(
      Uri.parse('https://student.valuxapps.com/api/profile'),
      headers: {
        'lang': 'en',
        'Authorization': token!,
      },
    );
    var responseData = jsonDecode(response.body);
    if (responseData['status'] == true) {
      userModel = UserModel.fromJson(responseData['data']);
      print('response is : $responseData');
      emit(GetUserDataSuccessState());
    } else {
      emit(GetUserDataFailedState(
        message: responseData['message'],
      ));
      print('response is : $responseData');
    }
  }

  List<BannerModel> banners = [];
  void getBannersData() async {
    Response response = await http
        .get(Uri.parse('https://student.valuxapps.com/api/banners'), headers: {
      'lang': 'en',
    });
    final responseData = jsonDecode(response.body);
    if (responseData['status'] == true) {
      for (var item in responseData['data']) {
        banners.add(BannerModel.fromJson(data: item));
      }
      emit(GetBannersDataSuccessState());
    } else {
      emit(GetBannersDataFailedState());
    }
  }

  List<CategoryModel> categories = [];
  void getCategory() async {
    Response response = await http.get(
        Uri.parse('https://student.valuxapps.com/api/categories'),
        headers: {
          'lang': 'en',
        });
    final responseData = jsonDecode(response.body);
    if (responseData['status'] == true) {
      for (var item in responseData['data']['data']) {
        categories.add(CategoryModel.fromJson(data: item));
      }
      emit(GetCategoriesSuccessState());
    } else {
      emit(FailedToGetCategoriesState());
    }
  }

  List<ProductModel> product = [];
  void getProductsData() async {
    Response response = await http.get(
      Uri.parse('https://student.valuxapps.com/api/home'),
      headers: {
        'lang': 'en',
        'Authorization': token!,
      },
    );
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      for (var item in responseBody['data']['products']) {
        product.add(ProductModel.fromJson(data: item));
      }
      emit(GetProductsDataSuccessState());
    } else {
      emit(GetProductsDataFailedState());
    }
  }

  List<ProductModel> filteredProducts = [];
  void filterProducts({required String input}) {
    filteredProducts = product
        .where((elment) =>
            elment.name!.toLowerCase().startsWith(input.toLowerCase()))
        .toList();
    emit(FilterProudectSuccessState());
  }

  List<ProductModel> favorites = [];
  Set<String> favoritesIds = {};
  Future<void> getFavorites() async {
    favorites.clear();
    Response response = await http.get(
      Uri.parse('https://student.valuxapps.com/api/favorites'),
      headers: {
        'lang': 'en',
        'Authorization': token!,
      },
    );
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      for (var item in responseBody['data']['data']) {
        favorites.add(ProductModel.fromJson(data: item['product']));
        favoritesIds.add(item['product']['id'].toString());
      }
      emit(GetFavoritesSuccessState());
    } else {
      emit(GetFavoritesFailedState());
    }
  }

  void addOrRemoveFavorite({required String productId}) async {
    Response response = await http.post(
      Uri.parse('https://student.valuxapps.com/api/favorites'),
      headers: {
        'lang': 'en',
        'Authorization': token!,
      },
      body: {
        'product_id': productId,
      },
    );
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      if (favoritesIds.contains(productId) == true) {
        favoritesIds.remove(productId);
      } else {
        favoritesIds.add(productId);
      }
      await getFavorites();
      emit(AddOrRemoveItemFromFavoritesSuccessState());
    } else {
      emit(FaildTOAddOrRemoveItemFromFavoritesState());
    }
  }

  List<ProductModel> carts = [];
  Set<String> cartsId = {};
  int totalPrice = 0;
  Future<void> getCarts() async {
    carts.clear();
    Response response = await http
        .get(Uri.parse('https://student.valuxapps.com/api/carts'), headers: {
      'lang': 'en',
      'Authorization': token!,
    });
    var responseBody = jsonDecode(response.body);
    totalPrice = responseBody['data']['total'].toInt();
    if (responseBody['status'] == true) {
      for (var item in responseBody['data']['cart_items']) {
        cartsId.add(item['product']['id'].toString());
        carts.add(ProductModel.fromJson(data: item['product']));
      }
      emit(GetCartsSuccessState());
    } else {
      emit(GetCartsFailedState());
    }
  }

  void addOrRemoveItemFromCart({required String productId}) async {
    Response response = await http.post(
      Uri.parse('https://student.valuxapps.com/api/carts'),
      headers: {
        'lang': 'en',
        'Authorization': token!,
      },
      body: {
        'product_id': productId,
      },
    );
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      cartsId.contains(productId) == true
          ? cartsId.remove(productId)
          : cartsId.add(productId);
      await getCarts();
      emit(AddCartsSuccessState());
    } else {
      emit(FaildAddCartsSuccessState());
    }
  }

  void changePassword(
      {required String userCurrentPassword,
      required String newPassword}) async {
    emit(ChangePasswordLoding());

    Response response = await http.post(
      Uri.parse('https://student.valuxapps.com/api/change-password'),
      headers: {
        'lang': 'en',
        'Authorization': token!,
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'current_password': userCurrentPassword,
        'new_password': newPassword,
      }),
    );
    var responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (responseBody['status'] == true) {
        await CacheNetwork.insertToCache(key: 'password', value: newPassword);
        currentPassword = await CacheNetwork.getCacheData(key: 'password');
        emit(ChangePasswordSuccess());
      } else {
        emit(ChangePasswordFaild(
          message: responseBody['message'],
        ));
      }
    } else {
      emit(ChangePasswordFaild(
        message: responseBody['something went wrong, please try again later'],
      ));
    }
  }

  void updateUserData({
    required String name,
    required String phone,
    required String email,
    File? image,
  }) async {
    emit(UpdateUserDataLoading());

    try {
      Response response = await http.put(
        Uri.parse('https://student.valuxapps.com/api/update-profile'),
        headers: {
          'lang': 'en',
          'Authorization': token!,
        },
        body: {
          'name': name,
          'phone': phone,
          'email': email,
        },
      );
      var responseBody = jsonDecode(response.body);
      if (responseBody['status'] == true) {
        await getUserData();

        emit(UpdateUserDataSuccess());
      } else {
        emit(UpdateUserDatafailyer(message: responseBody['message']));
      }
    } catch (e) {
      emit(
        UpdateUserDatafailyer(
          message: e.toString(),
        ),
      );
    }
  }

  void updateProfileData(
      {required String name, required String email, required String phone}) {}

  void logout() async {
    await CacheNetwork.deleteCacheData(key: 'token');
    await CacheNetwork.deleteCacheData(key: 'password');
    emit(LogoutSuccessState());
  }
}
