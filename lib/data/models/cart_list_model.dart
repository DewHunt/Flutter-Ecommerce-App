import 'package:ecommerce/data/models/cart_model.dart';

class CartListModel {
  String? msg;
  List<CartModel>? cartList;

  CartListModel({this.msg, this.cartList});

  CartListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      cartList = <CartModel>[];
      json['data'].forEach((v) {
        cartList!.add(CartModel.fromJson(v));
      });
    }
  }
}