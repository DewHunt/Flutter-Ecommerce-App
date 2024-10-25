import 'package:ecommerce/data/models/api_response.dart';
import 'package:ecommerce/data/models/category_list_model.dart';
import 'package:ecommerce/data/models/category_model.dart';
import 'package:ecommerce/data/services/api_caller.dart';
import 'package:ecommerce/data/utils/urls.dart';
import 'package:get/get.dart';

class CategoryListController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage = '';
  List<CategoryModel> _categoryList = [];

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  List<CategoryModel> get categoryList => _categoryList;

  Future<bool> getCategoryList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final ApiResponse apiResponse =
        await Get.find<ApiCaller>().getRequest(url: Urls.categoryListUrl);

    if (apiResponse.isSuccess) {
      _errorMessage = null;
      _categoryList =
          CategoryListModel.fromJson(apiResponse.responseBody).categoryList ??
              [];
      isSuccess = true;
    } else {
      _errorMessage = apiResponse.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }
}
