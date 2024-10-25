import 'package:ecommerce/data/models/review_model.dart';

class ReviewListModel {
  String? msg;
  List<ReviewModel>? reviewList;

  ReviewListModel({this.msg, this.reviewList});

  ReviewListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      reviewList = <ReviewModel>[];
      json['data'].forEach((v) {
        reviewList!.add(ReviewModel.fromJson(v));
      });
    }
  }
}
