import 'package:ecommerce/data/models/category_model.dart';
import 'package:ecommerce/data/models/product_model.dart';
import 'package:ecommerce/presentation/state_holders/state_holders.dart';
import 'package:ecommerce/presentation/ui/utils/utils.dart';
import 'package:ecommerce/presentation/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({
    super.key,
    required this.titleName,
    this.category,
    this.productList,
  });

  final String titleName;
  final CategoryModel? category;
  final List<ProductModel>? productList;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductListByCategoryController _productListByCategoryController =
      Get.find<ProductListByCategoryController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.category != null) {
        await _productListByCategoryController.getProductListByCategory(
          widget.category!.id!,
        );
      } else if (widget.productList != null) {
        if (_productListByCategoryController.productList.isEmpty) {
          await _productListByCategoryController.getProductListByCategory(0);
        }
        _productListByCategoryController.setProducts(
          widget.productList!,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titleName),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GetBuilder<ProductListByCategoryController>(
            builder: (productListByCategoryController) {
          if (productListByCategoryController.inProgress) {
            return const CenteredCircularProgressIndicator();
          } else if (productListByCategoryController.errorMessage != null) {
            return Center(
              child: Text(productListByCategoryController.errorMessage!),
            );
          } else if (productListByCategoryController.productList.isEmpty) {
            return const Center(
              child: Text(
                'Products not found!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.themeColor,
                ),
              ),
            );
          }
          return GridView.builder(
            itemCount: productListByCategoryController.productList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.87,
              mainAxisSpacing: 10,
              crossAxisSpacing: 4,
            ),
            itemBuilder: (context, index) {
              return ProductCard(
                cardWidth: 200,
                cardHeight: 160,
                imageScale: 1.5,
                product: productListByCategoryController.productList[index],
              );
            },
          );
        }),
      ),
    );
  }
}
