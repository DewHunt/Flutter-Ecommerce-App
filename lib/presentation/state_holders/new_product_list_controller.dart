import 'package:ecommerce/data/models/api_response.dart';
import 'package:ecommerce/data/models/product_list_model.dart';
import 'package:ecommerce/data/models/product_model.dart';
import 'package:ecommerce/data/services/api_caller.dart';
import 'package:ecommerce/data/utils/urls.dart';
import 'package:get/get.dart';

class NewProductListController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage = '';
  List<ProductModel> _productList = [];

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  List<ProductModel> get productList => _productList;

  Future<bool> getNewProductList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final ApiResponse apiResponse = await Get.find<ApiCaller>().getRequest(
      url: Urls.productListByRemark('new'),
    );

    if (apiResponse.isSuccess) {
      _errorMessage = null;
      _productList =
          ProductListModel.fromJson(apiResponse.responseBody).productList ?? [];
      isSuccess = true;
    } else {
      _errorMessage = apiResponse.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }
}
