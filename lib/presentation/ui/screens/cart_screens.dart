import 'package:ecommerce/presentation/state_holders/state_holders.dart';
import 'package:ecommerce/presentation/ui/utils/utils.dart';
import 'package:ecommerce/presentation/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreens extends StatefulWidget {
  const CartScreens({super.key});

  @override
  State<CartScreens> createState() => _CartScreensState();
}

class _CartScreensState extends State<CartScreens> {
  @override
  void initState() {
    super.initState();
    Get.find<CartListController>().getCartList();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool dipPop, Object? result) {
        backToHome();
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: const Text('Carts'),
          leading: IconButton(
            onPressed: backToHome,
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: GetBuilder<CartListController>(
          builder: (cartListController) {
            if (cartListController.inProgress) {
              return const CenteredCircularProgressIndicator();
            } else if (cartListController.errorMessage != null) {
              return Center(
                child: Text(cartListController.errorMessage!),
              );
            } else if (cartListController.cartList.isEmpty) {
              return const Center(
                child: Text(
                  'Cart Is Empty',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.themeColor,
                  ),
                ),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartListController.cartList.length,
                    itemBuilder: (context, index) {
                      return CartItemCardWidget(
                        cartInfo: cartListController.cartList[index],
                        onTap: () {
                          debugPrint("Dew Hunt");
                        },
                      );
                    },
                  ),
                ),
                CartTotalPriceAndCheckoutWidget(
                  cartList: cartListController.cartList,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void backToHome() => Get.find<BottomNavBarController>().backToHome();
}
