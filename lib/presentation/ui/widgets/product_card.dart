import 'package:ecommerce/data/models/product_model.dart';
import 'package:ecommerce/presentation/state_holders/state_holders.dart';
import 'package:ecommerce/presentation/ui/screens/email_verification_screen.dart';
import 'package:ecommerce/presentation/ui/screens/product_details_screen.dart';
import 'package:ecommerce/presentation/ui/utils/app_colors.dart';
import 'package:ecommerce/presentation/ui/utils/snack_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.cardWidth,
    required this.cardHeight,
    required this.imageScale,
    required this.product,
  });

  final double cardWidth;
  final double cardHeight;
  final double imageScale;
  final ProductModel? product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetailsScreen(productId: widget.product!.id ?? 0));
      },
      child: Card(
        color: Colors.white,
        elevation: 4,
        child: SizedBox(
          width: widget.cardWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageSection(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTitleSection(),
                      SizedBox(
                        width: 180,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildPriceSection(),
                            _buildRatingSection(),
                            _buildWishSection(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Container(
      width: widget.cardWidth,
      height: widget.cardHeight,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.themeColor.withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          scale: widget.imageScale,
          image: NetworkImage(widget.product?.image ?? ''),
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Text(
      widget.product?.title ?? '',
      maxLines: 1,
      style: const TextStyle(
        color: Colors.black54,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildPriceSection() {
    return Text(
      '৳${widget.product?.price}',
      style: const TextStyle(
        color: AppColors.themeColor,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildRatingSection() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        const Icon(Icons.star, color: Colors.amber),
        Text(
          '${widget.product?.star}',
          style: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildWishSection() {
    return GestureDetector(
      onTap: _onTapCreateWish,
      child: Card(
        color: AppColors.themeColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Padding(
          padding: EdgeInsets.all(4.0),
          child: Icon(
            Icons.favorite_border_outlined,
            size: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Future<void> _onTapCreateWish() async {
    bool isLoggedInUser = Get.find<AuthController>().isLoggedInUser();
    if (isLoggedInUser) {
      final CreateWishController createWishController =
          Get.find<CreateWishController>();
      final result = await createWishController.createWish(widget.product?.id);

      if (mounted) {
        if (result) {
          debugPrint('Dew Hunt');
          showSnackBarMessage(context, 'Added to your wish list');
        } else {
          showSnackBarMessage(
            context,
            createWishController.errorMessage!,
            true,
          );
        }
      }
    } else {
      if (mounted) {
        Get.to(() => const EmailVerificationScreen());
      }
    }
  }
}
