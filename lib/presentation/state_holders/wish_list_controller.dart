import 'package:ecommerce/data/models/api_response.dart';
import 'package:ecommerce/data/models/wish_list_model.dart';
import 'package:ecommerce/data/models/wish_model.dart';
import 'package:ecommerce/data/services/api_caller.dart';
import 'package:ecommerce/data/utils/urls.dart';
import 'package:get/get.dart';

class WishListController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage = '';
  List<WishModel> _wishList = [];

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  List<WishModel> get wishList => _wishList;

  Future<bool> getWishList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final ApiResponse apiResponse = await Get.find<ApiCaller>().getRequest(
      url: Urls.wishList,
    );

    if (apiResponse.isSuccess) {
      _errorMessage = null;
      _wishList =
          WishListModel.fromJson(apiResponse.responseBody).wishList ?? [];
      isSuccess = true;
    } else {
      _errorMessage = apiResponse.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }
}
