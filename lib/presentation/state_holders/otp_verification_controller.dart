import 'package:ecommerce/data/models/api_response.dart';
import 'package:ecommerce/data/services/api_caller.dart';
import 'package:ecommerce/data/utils/urls.dart';
import 'package:get/get.dart';

class OtpVerificationController extends GetxController {
  bool _inProgress = false;
  String _accessToken = '';
  String? _errorMessage;

  bool get inProgress => _inProgress;

  String get accessToken => _accessToken;

  String? get errorMessage => _errorMessage;

  Future<bool> verifyOtp(String email, String otp) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final ApiResponse apiResponse = await Get.find<ApiCaller>().getRequest(
      url: Urls.verifyOtp(email, otp),
    );

    if (apiResponse.isSuccess && apiResponse.responseBody['msg'] == 'success') {
      _errorMessage = null;
      _accessToken = apiResponse.responseBody['data'];
      isSuccess = true;
    } else {
      _errorMessage = apiResponse.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
