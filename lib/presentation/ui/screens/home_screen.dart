import 'package:ecommerce/presentation/state_holders/state_holders.dart';
import 'package:ecommerce/presentation/ui/screens/email_verification_screen.dart';
import 'package:ecommerce/presentation/ui/screens/product_list_screen.dart';
import 'package:ecommerce/presentation/ui/screens/user_profile_screen.dart';
import 'package:ecommerce/presentation/ui/utils/utils.dart';
import 'package:ecommerce/presentation/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SearchTextField(
                textEditingController: TextEditingController(),
              ),
              const SizedBox(height: 8),
              const HomeBannerSlider(),
              const SizedBox(height: 8),
              _buildCategoriesSection(),
              const SizedBox(height: 8),
              _buildPopularProductSection(),
              const SizedBox(height: 8),
              _buildSpecialProductSection(),
              const SizedBox(height: 8),
              _buildNewProductSection(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: SvgPicture.asset(AssetsPath.appLogoNave),
      actions: [
        AppBarIconButton(
          iconData: Icons.person_outline_sharp,
          onTap: _onTapUserProfile,
        ),
        const SizedBox(width: 8),
        AppBarIconButton(
          iconData: Icons.phone_outlined,
          onTap: () {},
        ),
        const SizedBox(width: 8),
        AppBarIconButton(
          iconData: Icons.notifications_active_outlined,
          onTap: () {},
        ),
        const SizedBox(width: 8),
        if (_authController.isLoggedInUser())
          AppBarIconButton(
            iconData: Icons.logout_outlined,
            onTap: _onTapLogout,
          ),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      children: [
        SectionHeader(
          title: 'All Categories',
          onTap: () {
            Get.find<BottomNavBarController>().selectCategoryScreen();
          },
        ),
        SizedBox(
          height: 120,
          child: GetBuilder<CategoryListController>(
              builder: (categoryListController) {
            return Visibility(
              visible: !categoryListController.inProgress,
              replacement: const CenteredCircularProgressIndicator(),
              child: HorizontalCategoryListView(
                categoryList: categoryListController.categoryList,
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildPopularProductSection() {
    return Column(
      children: [
        SectionHeader(
          title: 'Popular',
          onTap: () {
            Get.to(
              () => ProductListScreen(
                titleName: 'Popular Products',
                productList:
                    Get.find<PopularProductListController>().productList,
              ),
            );
          },
        ),
        SizedBox(
          height: 210,
          child: GetBuilder<PopularProductListController>(
              builder: (popularProductListController) {
            return Visibility(
              visible: !popularProductListController.inProgress,
              replacement: const CenteredCircularProgressIndicator(),
              child: HorizontalProductListView(
                productList: popularProductListController.productList,
              ),
            );
          }),
        )
      ],
    );
  }

  Widget _buildSpecialProductSection() {
    return Column(
      children: [
        SectionHeader(
          title: 'Special',
          onTap: () {
            Get.to(
              () => ProductListScreen(
                titleName: 'Special Products',
                productList:
                    Get.find<SpecialProductListController>().productList,
              ),
            );
          },
        ),
        SizedBox(
          height: 210,
          child: GetBuilder<SpecialProductListController>(
              builder: (specialProductListController) {
            return Visibility(
              visible: !specialProductListController.inProgress,
              replacement: const CenteredCircularProgressIndicator(),
              child: HorizontalProductListView(
                productList: specialProductListController.productList,
              ),
            );
          }),
        )
      ],
    );
  }

  Widget _buildNewProductSection() {
    return Column(
      children: [
        SectionHeader(
          title: 'New',
          onTap: () {
            Get.to(
              () => ProductListScreen(
                titleName: 'New Products',
                productList: Get.find<NewProductListController>().productList,
              ),
            );
          },
        ),
        SizedBox(
          height: 210,
          child: GetBuilder<NewProductListController>(
              builder: (newProductListController) {
            return Visibility(
              visible: !newProductListController.inProgress,
              replacement: const CenteredCircularProgressIndicator(),
              child: HorizontalProductListView(
                productList: newProductListController.productList,
              ),
            );
          }),
        )
      ],
    );
  }

  Future<void> _onTapLogout() async {
    String? token = await _authController.getAccessToken();
    await _authController.clearUserData();
    debugPrint("Access Token: $token");
    debugPrint("Logout Called");
    setState(() {});
    // bool result = await _logoutController.logout();
    //
    // if (result) {
    //   debugPrint(_authController.getAccessToken().toString());
    //   _authController.clearUserData();
    // } else {
    //   if (mounted) {
    //     showSnackBarMessage(context, _logoutController.errorMessage!, true);
    //   }
    // }
  }

  void _onTapUserProfile() {
    if (_authController.isLoggedInUser()) {
      debugPrint("Logged User");
      Get.to(() => const UserProfileScreen());
    } else {
      Get.to(const EmailVerificationScreen());
    }
  }
}
