import 'package:ecommerce/data/models/wish_model.dart';

class WishListModel {
  String? msg;
  List<WishModel>? wishList;

  WishListModel({this.msg, this.wishList});

  WishListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      wishList = <WishModel>[];
      json['data'].forEach((v) {
        wishList!.add(WishModel.fromJson(v));
      });
    }
  }
}
