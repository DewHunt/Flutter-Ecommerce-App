import 'package:ecommerce/data/models/cart_model.dart';
import 'package:ecommerce/presentation/state_holders/state_holders.dart';
import 'package:ecommerce/presentation/ui/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

class CartItemCardWidget extends StatefulWidget {
  const CartItemCardWidget({
    super.key,
    required this.cartInfo,
    required this.onTap,
  });

  final CartModel cartInfo;
  final VoidCallback onTap;

  @override
  State<CartItemCardWidget> createState() => _CartItemCardWidgetState();
}

class _CartItemCardWidgetState extends State<CartItemCardWidget> {
  // late int _quantity;
  // late int _price;

  @override
  void initState() {
    super.initState();
    // _quantity = int.parse(widget.cartInfo.qty.toString());
    // _price = int.parse(widget.cartInfo.price.toString());
  }

  @override
  Widget build(BuildContext context) {
    late TextTheme textTheme = Theme.of(context).textTheme;

    return Card(
      color: Colors.white,
      elevation: 4,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            _buildItemImageSection(),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  _buildItemDetailsSection(textTheme),
                  _buildPriceAndButtonsSection(textTheme),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemImageSection() {
    return Image.asset(
      width: 100,
      height: 100,
      fit: BoxFit.scaleDown,
      AssetsPath.dummyProductImg,
    );
  }

  Row _buildItemDetailsSection(TextTheme textTheme) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.cartInfo.product?.title ?? '',
                style: textTheme.bodyLarge,
              ),
              Wrap(
                children: [
                  Text(
                    'Color: ${widget.cartInfo.color}',
                    style: textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Size: ${widget.cartInfo.size}',
                    style: textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row _buildPriceAndButtonsSection(TextTheme textTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '৳${widget.cartInfo.price ?? 1}',
          style: textTheme.titleMedium?.copyWith(
            color: AppColors.themeColor,
          ),
        ),
        Wrap(
          spacing: 5,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            _buildItemIncDecButton(),
            _buildItemDeleteButton(),
          ],
        ),
      ],
    );
  }

  Widget _buildItemIncDecButton() {
    return ItemCount(
      initialValue: int.parse(widget.cartInfo.qty.toString()),
      minValue: 1,
      maxValue: 100,
      decimalPlaces: 0,
      color: AppColors.themeColor,
      onChanged: (value) {
        Get.find<CartListController>().changeItem(
          widget.cartInfo.id!.toInt(),
          value.toInt(),
        );
      },
    );
  }

  Widget _buildItemDeleteButton() {
    return IconButton(
      onPressed: () {
        Get.find<CartListController>().deleteFromCart(
          widget.cartInfo.id!.toInt(),
        );
      },
      icon: const Icon(
        color: Colors.red,
        Icons.delete,
      ),
    );
  }
}
