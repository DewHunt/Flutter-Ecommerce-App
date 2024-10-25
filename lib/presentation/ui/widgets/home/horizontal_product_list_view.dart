import 'package:ecommerce/data/models/product_model.dart';
import 'package:ecommerce/presentation/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';

class HorizontalProductListView extends StatelessWidget {
  const HorizontalProductListView({
    super.key,
    required this.productList,
  });

  final List<ProductModel> productList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: productList.length,
      itemBuilder: (context, int index) {
        return ProductCard(
          cardWidth: 160,
          cardHeight: 130,
          imageScale: 1.5,
          product: productList[index],
        );
      },
      separatorBuilder: (_, __) => const SizedBox(width: 10),
    );
  }
}
