import 'package:ecommerce/data/models/cart_model.dart';
import 'package:ecommerce/presentation/state_holders/state_holders.dart';
import 'package:ecommerce/presentation/ui/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartTotalPriceAndCheckoutWidget extends StatefulWidget {
  const CartTotalPriceAndCheckoutWidget({super.key, required this.cartList});

  final List<CartModel> cartList;

  @override
  State<CartTotalPriceAndCheckoutWidget> createState() =>
      _CartTotalPriceAndCheckoutWidgetState();
}

class _CartTotalPriceAndCheckoutWidgetState
    extends State<CartTotalPriceAndCheckoutWidget> {
  // int _totalPrice = 0;

  @override
  void initState() {
    super.initState();
    // _totalPrice = _getTotalPrice();
  }

  // int _getTotalPrice() {
  //   return widget.cartList
  //       .fold(0, (sum, item) => sum + int.parse(item.price.toString()));
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: AppColors.themeColor.withOpacity(0.2),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const Text(
                'Total Price',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '৳${Get.find<CartListController>().totalPrice}',
                style: const TextStyle(
                  color: AppColors.themeColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 160,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Checkout'),
            ),
          )
        ],
      ),
    );
  }
}
