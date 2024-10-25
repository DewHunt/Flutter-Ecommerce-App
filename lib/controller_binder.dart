import 'package:ecommerce/data/services/api_caller.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'presentation/state_holders/state_holders.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(Logger());
    Get.put(AuthController());
    Get.put(
      ApiCaller(
        logger: Get.find<Logger>(),
        authController: Get.find<AuthController>(),
      ),
    );
    Get.put(ProductListByCategoryController());
    Get.put(ProductDetailsController());
    Get.put(AddToCartController());
    Get.put(EmailVerificationController());
    Get.put(TimerController());
    Get.put(BottomNavBarController());
    Get.put(SliderListController());
    Get.put(CategoryListController());
    Get.put(NewProductListController());
    Get.put(PopularProductListController());
    Get.put(SpecialProductListController());
    Get.put(OtpVerificationController());
    Get.put(ReadProfileController());
    Get.put(CompleteProfileController());
    Get.put(LogoutController());
    Get.put(CartListController());
    Get.put(ReviewListController());
    Get.put(CreateReviewController());
    Get.put(WishListController());
    Get.put(CreateWishController());
  }
}
