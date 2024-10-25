import 'package:ecommerce/presentation/state_holders/state_holders.dart';
import 'package:ecommerce/presentation/ui/screens/email_verification_screen.dart';
import 'package:ecommerce/presentation/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:ecommerce/presentation/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  final AuthController _authController = Get.find<AuthController>();
  final WishListController _wishListController = Get.find<WishListController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_authController.isLoggedInUser()) {
        Get.to(() => const EmailVerificationScreen());
      } else {
        _wishListController.getWishList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool dipPop, Object? result) {
        backToHome();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Wish List'),
          leading: IconButton(
            onPressed: backToHome,
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GetBuilder<WishListController>(builder: (wishListController) {
            if (wishListController.inProgress) {
              return const CenteredCircularProgressIndicator();
            } else if (wishListController.errorMessage != null) {
              return Center(
                child: Text(wishListController.errorMessage!),
              );
            } else if (wishListController.wishList.isEmpty) {
              return const Center(
                child: Text('Wish list not empty'),
              );
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.87,
                mainAxisSpacing: 10,
                crossAxisSpacing: 4,
              ),
              itemCount: wishListController.wishList.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  cardWidth: 200,
                  cardHeight: 160,
                  imageScale: 1.5,
                  product: wishListController.wishList[index].product,
                );
              },
            );
          }),
        ),
      ),
    );
  }

  void backToHome() => Get.find<BottomNavBarController>().backToHome();
}
