import 'package:ecommerce/data/models/api_response.dart';
import 'package:ecommerce/data/models/product_details_model.dart';
import 'package:ecommerce/data/services/api_caller.dart';
import 'package:ecommerce/data/utils/urls.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage = '';
  ProductDetailsModel? _productModel;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  ProductDetailsModel? get productDetails => _productModel;

  Future<bool> getProductDetails(int id) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final ApiResponse apiResponse = await Get.find<ApiCaller>().getRequest(
      url: Urls.productDetailsById(id),
    );

    if (apiResponse.isSuccess) {
      _errorMessage = null;
      if (apiResponse.responseBody['data'].isNotEmpty) {
        _productModel = ProductDetailsModel.fromJson(
          apiResponse.responseBody['data'][0],
        );
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
