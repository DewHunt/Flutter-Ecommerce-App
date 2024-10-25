import 'package:ecommerce/data/models/api_response.dart';
import 'package:ecommerce/data/models/review_list_model.dart';
import 'package:ecommerce/data/models/review_model.dart';
import 'package:ecommerce/data/services/api_caller.dart';
import 'package:ecommerce/data/utils/urls.dart';
import 'package:get/get.dart';

class ReviewListController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage = '';
  List<ReviewModel> _reviewList = [];

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  List<ReviewModel> get reviewList => _reviewList;

  Future<bool> getReviewList(int id) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final ApiResponse apiResponse = await Get.find<ApiCaller>().getRequest(
      url: Urls.reviewListByProduct(id),
    );

    if (apiResponse.isSuccess) {
      _errorMessage = null;
      _reviewList =
          ReviewListModel.fromJson(apiResponse.responseBody).reviewList ?? [];
      isSuccess = true;
    } else {
      _errorMessage = apiResponse.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }
}
