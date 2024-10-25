import 'package:ecommerce/data/models/api_response.dart';
import 'package:ecommerce/data/models/cart_list_model.dart';
import 'package:ecommerce/data/models/cart_model.dart';
import 'package:ecommerce/data/services/api_caller.dart';
import 'package:ecommerce/data/utils/urls.dart';
import 'package:get/get.dart';

class CartListController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage = '';
  List<CartModel> _cartList = [];
  double _totalPrice = 0;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  List<CartModel> get cartList => _cartList;

  double get totalPrice => _totalPrice;

  Future<bool> getCartList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final ApiResponse apiResponse = await Get.find<ApiCaller>().getRequest(
      url: Urls.cartList,
    );

    if (apiResponse.isSuccess) {
      _errorMessage = null;
      _cartList =
          CartListModel.fromJson(apiResponse.responseBody).cartList ?? [];
      _calculateTotalPrice();
      isSuccess = true;
    } else {
      _errorMessage = apiResponse.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }

  void _calculateTotalPrice() {
    _totalPrice = 0;
    for (CartModel cart in _cartList) {
      _totalPrice += ((double.tryParse(cart.product?.price ?? '0') ?? 0) *
          (int.parse(cart.qty.toString())));
      cart.price = ((double.tryParse(cart.product?.price ?? '0') ?? 0) *
          (int.parse(cart.qty.toString()))).toString();
    }
    update();
  }

  void changeItem(int cartId, int qty) {
    _cartList.firstWhere((cartInfo) => cartInfo.id == cartId).qty =
        qty.toString();
    _calculateTotalPrice();
  }

  Future<void> deleteFromCart(int id) async {
    _inProgress = true;
    update();

    final ApiResponse apiResponse = await Get.find<ApiCaller>().getRequest(
      url: Urls.deleteFromCartList(id),
    );

    if (apiResponse.isSuccess) {
      _errorMessage = null;
      _cartList.removeWhere((item) => item.id == id);
      _calculateTotalPrice();
    } else {
      _errorMessage = apiResponse.errorMessage;
    }

    _inProgress = false;
    update();
  }
}
