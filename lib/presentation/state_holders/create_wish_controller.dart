import 'package:ecommerce/data/models/api_response.dart';
import 'package:ecommerce/data/services/api_caller.dart';
import 'package:ecommerce/data/utils/urls.dart';
import 'package:get/get.dart';

class CreateWishController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage = '';

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  Future<bool> createWish(id) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final ApiResponse apiResponse = await Get.find<ApiCaller>().getRequest(
      url: Urls.createWish(id),
    );

    if (apiResponse.isSuccess && apiResponse.responseBody['msg'] == 'success') {
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = apiResponse.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }
}
