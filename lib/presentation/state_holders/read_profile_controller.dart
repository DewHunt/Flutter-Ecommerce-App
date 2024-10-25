import 'package:ecommerce/data/models/api_response.dart';
import 'package:ecommerce/data/models/user_profile_model.dart';
import 'package:ecommerce/data/services/api_caller.dart';
import 'package:ecommerce/data/utils/urls.dart';
import 'package:ecommerce/presentation/state_holders/auth_controller.dart';
import 'package:get/get.dart';

class ReadProfileController extends GetxController {
  bool _inProgress = false;
  bool _isProfileCompleted = false;
  String? _errorMessage = '';
  UserProfileModel? _userProfileModel;

  bool get inProgress => _inProgress;

  bool get isProfileCompleted => _isProfileCompleted;

  String? get errorMessage => _errorMessage;

  UserProfileModel? get userProfile => _userProfileModel;

  Future<bool> getProfileDetails(String token) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final ApiResponse apiResponse = await Get.find<ApiCaller>().getRequest(
      url: Urls.readProfile,
      token: token,
    );

    if (apiResponse.isSuccess) {
      _errorMessage = null;
      _isProfileCompleted = false;
      if (apiResponse.responseBody['data'] != null) {
        _isProfileCompleted = true;
        _userProfileModel = UserProfileModel.fromJson(
          apiResponse.responseBody['data'],
        );
        AuthController authController = Get.find<AuthController>();
        await authController.saveAccessToken(token);
        await authController.saveUserProfileData(_userProfileModel!);
      }
      isSuccess = true;
    } else {
      _errorMessage = apiResponse.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }
}
