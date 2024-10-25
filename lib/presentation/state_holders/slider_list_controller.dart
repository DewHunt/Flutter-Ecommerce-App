import 'package:ecommerce/data/models/slider_model.dart';
import 'package:ecommerce/data/models/api_response.dart';
import 'package:ecommerce/data/models/slider_list_model.dart';
import 'package:ecommerce/data/services/api_caller.dart';
import 'package:ecommerce/data/utils/urls.dart';
import 'package:get/get.dart';

class SliderListController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  List<SliderModel> _sliderLists = [];

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  List<SliderModel> get sliderList => _sliderLists;

  Future<bool> getSliderList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final ApiResponse apiResponse =
        await Get.find<ApiCaller>().getRequest(url: Urls.sliderListUrl);

    if (apiResponse.isSuccess) {
      _errorMessage = null;
      _sliderLists =
          SliderListModel.fromJson(apiResponse.responseBody).sliderList ?? [];
      isSuccess = true;
    } else {
      _errorMessage = apiResponse.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
