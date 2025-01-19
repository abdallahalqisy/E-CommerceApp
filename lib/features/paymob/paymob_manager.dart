import 'package:dio/dio.dart';
import 'package:fashionapp/constents.dart';
import 'package:fashionapp/core/models/user_model.dart';
import 'package:fashionapp/layout/layout_cubit/layout_cubit.dart';

class PaymobManager {
  Dio dio = Dio();
  Future<String> payWithPaymob(int amount) async {
    try {
      String token = await getToken();
      int orderId =
          await getorderId(token: token, amount: (amount * 100).toString());
      String paymentKey = await getPaymentKey(
          token: token, orderId: orderId.toString(), amount: '100');
      return paymentKey;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getToken() async {
    try {
      Response response =
          await dio.post('https://accept.paymob.com/api/token', data: {
        "api_key": Constant.apiKay,
      });
      return response.data['token'];
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getorderId(
      {required String token, required String amount}) async {
    try {
      Response response = await dio.post(
          'https://accept.paymob.com/api/ecommerce/orders/transaction_inquiry',
          data: {
            "auth_token": token,
            "delivery_needed": "false",
            "amount_cents": amount,
            "currency": "EGP",
            'items': []
          });
      return response.data['id'];
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getPaymentKey(
      {required String token,
      required String orderId,
      required String amount}) async {
    try {
      UserModel? user = (await LayoutCubit()
        ..getUserData()) as UserModel?;
      Response response = await dio
          .post('https://accept.paymob.com/api/acceptance/payment_keys', data: {
        "auth_token": token,
        "amount_cents": amount,
        "currency": "EGP",
        "order_id": orderId,
        "billing_data": {
          "apartment": "803",
          "email": user!.email,
          "floor": "42",
          "first_name": user.name,
          "street": "Ethan Land",
          "building": "8028",
          "phone_number": user.phone,
          "shipping_method": "PKG",
          "postal_code": "01898",
          "city": "Jaskolskiburgh",
          "country": "CR",
          "last_name": "Williams",
          "state": "Utah"
        },
        "currency": "EGP",
        "integration_id": 297,
        "lock_order_when_paid": "false"
      });
      return response.data['token'];
    } catch (e) {
      rethrow;
    }
  }
}
