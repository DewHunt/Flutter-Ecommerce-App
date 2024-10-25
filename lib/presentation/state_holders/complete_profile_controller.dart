import 'package:ecommerce/data/models/api_response.dart';
import 'package:ecommerce/data/services/api_caller.dart';
import 'package:ecommerce/data/utils/urls.dart';
import 'package:get/get.dart';

class CompleteProfileController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage = '';

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  Future<bool> completeProfile(
    String token,
    Map<String, dynamic> requestData,
  ) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final ApiResponse apiResponse = await Get.find<ApiCaller>().postRequest(
      url: Urls.createProfile,
      body: requestData,
      token: token,
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
