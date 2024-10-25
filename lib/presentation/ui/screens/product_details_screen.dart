import 'package:ecommerce/data/models/product_details_model.dart';
import 'package:ecommerce/presentation/state_holders/state_holders.dart';
import 'package:ecommerce/presentation/ui/screens/email_verification_screen.dart';
import 'package:ecommerce/presentation/ui/screens/reviews_screen.dart';
import 'package:ecommerce/presentation/ui/utils/utils.dart';
import 'package:ecommerce/presentation/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  final int productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String _selectedColor = '';
  String _selectedSize = '';
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Get.find<ProductDetailsController>()
          .getProductDetails(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: GetBuilder<ProductDetailsController>(
        builder: (productDetailsController) {
          if (productDetailsController.inProgress) {
            return const CenteredCircularProgressIndicator();
          } else if (productDetailsController.errorMessage != null) {
            return Center(
              child: Text(productDetailsController.errorMessage!),
            );
          } else if (productDetailsController.productDetails == null) {
            return const Center(
              child: Text("Product is not available"),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildBodySection(
                  productDetailsController.productDetails!,
                ),
              ),
              _buildFooterSection(productDetailsController.productDetails!),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBodySection(ProductDetailsModel productDetails) {
    List<String> colors = productDetails.color!.split(',');
    List<String> sizes = productDetails.size!.split(',');
    _selectedColor = colors.first;
    _selectedSize = sizes.first;

    return SingleChildScrollView(
      child: Column(
        children: [
          ProductImageSlider(
            sliderUrls: [
              productDetails.img1!,
              productDetails.img2!,
              productDetails.img3!,
              productDetails.img4!,
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildItemTitleSection(productDetails.product?.title ?? ''),
                _buildReviewSection(productDetails),
                const SizedBox(height: 4),
                _buildColorPickerSection(colors),
                const SizedBox(height: 16),
                _buildSizePickerSection(sizes),
                const SizedBox(height: 16),
                _buildDescriptionSection(
                    productDetails.product?.shortDes ?? ''),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemTitleSection(String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        _buildItemIncDecButton(),
      ],
    );
  }

  Widget _buildItemIncDecButton() {
    return ItemCount(
      initialValue: _quantity,
      minValue: 1,
      maxValue: 100,
      decimalPlaces: 0,
      color: AppColors.themeColor,
      buttonSizeWidth: 35,
      buttonSizeHeight: 30,
      onChanged: (value) {
        _quantity = value.toInt();
        setState(() {});
      },
    );
  }

  Widget _buildReviewSection(ProductDetailsModel productDetails) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 10,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Icon(Icons.star, color: Colors.amber),
            Text(
              (productDetails.product?.star ?? 0).toString(),
              style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            Get.to(
              () => ReviewsScreen(
                productId: productDetails.productId!.toInt(),
              ),
            );
          },
          child: const Text('Reviews'),
        ),
        GestureDetector(
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
        ),
      ],
    );
  }

  // Widget _buildColorPickerSection(String colors) {
  //   return ColorPicker(
  //     colors: const [
  //       Colors.green,
  //       Colors.red,
  //       Colors.yellow,
  //       Colors.blue,
  //       Colors.black,
  //     ],
  //     onColorSelected: (color) {},
  //   );
  // }

  Widget _buildColorPickerSection(List<String> colors) {
    return SizePicker(
      sizes: colors,
      onSizeSelected: (color) {
        _selectedColor = color;
      },
    );
  }

  Widget _buildSizePickerSection(List<String> sizes) {
    return SizePicker(
      sizes: sizes,
      onSizeSelected: (size) {
        _selectedSize = size;
      },
    );
  }

  Widget _buildDescriptionSection(String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          '''$description.''',
          textAlign: TextAlign.justify,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildFooterSection(ProductDetailsModel productDetails) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.themeColor.withOpacity(0.2),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Price',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '৳${productDetails.product?.price}',
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
            child: GetBuilder<AddToCartController>(
              builder: (addToCartController) {
                return Visibility(
                  visible: !addToCartController.inProgress,
                  replacement: const CenteredCircularProgressIndicator(),
                  child: ElevatedButton(
                    onPressed: _onTapAddToCart,
                    child: const Text(
                      'Add To Cart',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onTapAddToCart() async {
    bool isLoggedInUser = Get.find<AuthController>().isLoggedInUser();
    if (isLoggedInUser) {
      final AddToCartController addToCartController =
          Get.find<AddToCartController>();
      final result = await addToCartController.addToCart(
        widget.productId,
        _selectedColor,
        _selectedSize,
        _quantity,
      );

      if (mounted) {
        if (result) {
          showSnackBarMessage(context, 'Added to cart');
        } else {
          showSnackBarMessage(
            context,
            addToCartController.errorMessage!,
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

  Future<void> _onTapCreateWish() async {
    bool isLoggedInUser = Get.find<AuthController>().isLoggedInUser();
    if (isLoggedInUser) {
      final CreateWishController createWishController =
          Get.find<CreateWishController>();
      final result = await createWishController.createWish(widget.productId);

      if (mounted) {
        if (result) {
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
