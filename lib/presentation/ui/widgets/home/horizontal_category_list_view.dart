import 'package:ecommerce/data/models/category_model.dart';
import 'package:ecommerce/presentation/ui/widgets/category_card.dart';
import 'package:flutter/material.dart';

class HorizontalCategoryListView extends StatelessWidget {
  const HorizontalCategoryListView({
    super.key,
    required this.categoryList,
  });

  final List<CategoryModel> categoryList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: categoryList.length,
      itemBuilder: (context, index) {
        return CategoryCard(category: categoryList[index]);
      },
      separatorBuilder: (_, __) => const SizedBox(width: 8),
    );
  }
}
