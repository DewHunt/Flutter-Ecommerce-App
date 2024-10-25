import 'package:ecommerce/data/models/api_response.dart';
import 'package:ecommerce/data/services/api_caller.dart';
import 'package:ecommerce/data/utils/urls.dart';
import 'package:get/get.dart';

class AddToCartController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  Future<bool> addToCart(
    int productId,
    String color,
    String size,
    int quantity,
  ) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final ApiResponse apiResponse = await Get.find<ApiCaller>().postRequest(
      url: Urls.addToCart,
      body: {
        'product_id': productId,
        'color': color,
        'size': size,
        'qty': quantity,
      },
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
