import 'package:ecommerce/data/models/category_model.dart';
import 'package:ecommerce/presentation/ui/screens/product_list_screen.dart';
import 'package:ecommerce/presentation/ui/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => ProductListScreen(
            titleName: category.categoryName ?? '',
            category: category,
          ),
        );
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.themeColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.network(
              category.categoryImg ?? '',
              width: 63,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            category.categoryName ?? '',
            style: const TextStyle(
              color: AppColors.themeColor,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
