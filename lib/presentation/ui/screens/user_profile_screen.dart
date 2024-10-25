import 'package:ecommerce/data/models/user_profile_model.dart';
import 'package:ecommerce/presentation/state_holders/auth_controller.dart';
import 'package:ecommerce/presentation/state_holders/read_profile_controller.dart';
import 'package:ecommerce/presentation/ui/screens/complete_profile_screen.dart';
import 'package:ecommerce/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:ecommerce/presentation/ui/utils/utils.dart';
import 'package:ecommerce/presentation/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ReadProfileController _readProfileController =
      Get.find<ReadProfileController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    Future.delayed(Duration.zero, () {
      _readProfileController.getProfileDetails(AuthController.accessToken!);
    });

    _tabController.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ReadProfileController>(
        builder: (readProfileController) {
          if (readProfileController.inProgress) {
            return const CenteredCircularProgressIndicator();
          } else if (readProfileController.errorMessage != null) {
            return Center(
              child: Text(readProfileController.errorMessage!),
            );
          } else if (readProfileController.userProfile == null) {
            return const Center(
              child: Text("No profile information available"),
            );
          }
          return Scaffold(
            appBar: _buildAppBar(readProfileController.userProfile!.cusName),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  _buildTabBar(),
                  const SizedBox(height: 8),
                  _buildTabBarView(readProfileController.userProfile),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(
                        () => CompleteProfileScreen(
                          accessToken: AuthController.accessToken!,
                          isUpdate: true,
                        ),
                      );
                    },
                    child: const Text('Update Your Profile'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(String? title) {
    return AppBar(
      title: Text(title ?? ''),
      leading: IconButton(
        onPressed: () {
          Get.to(() => const MainBottomNavScreen());
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.themeColor,
          width: 3.5,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: AppColors.themeColor,
          borderRadius: _tabController.index == 0
              ? const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.zero,
                  bottomRight: Radius.zero,
                  bottomLeft: Radius.circular(25),
                )
              : const BorderRadius.only(
                  topLeft: Radius.zero,
                  topRight: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.zero,
                ),
        ),
        indicatorColor: AppColors.themeColor,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        labelStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        dividerColor: AppColors.themeColor,
        dividerHeight: 0,
        tabs: const [
          Tab(text: 'Personal Information'),
          Tab(text: 'Shipping Address'),
        ],
      ),
    );
  }

  Widget _buildTabBarView(UserProfileModel? userProfile) {
    if (userProfile == null) {
      return const Center(child: Text("No user profile available"));
    }

    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildPersonalInformation(userProfile),
          _buildShippingAddress(userProfile),
        ],
      ),
    );
  }

  Widget _buildPersonalInformation(UserProfileModel? userProfile) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: FlexColumnWidth(1.5),
        1: FlexColumnWidth(4),
      },
      children: [
        _buildTableRow('Name', userProfile?.cusName ?? ''),
        _buildTableRow('Phone', userProfile?.cusPhone ?? ''),
        _buildTableRow('Fax', userProfile?.cusFax ?? ''),
        _buildTableRow('City', userProfile?.cusCity ?? ''),
        _buildTableRow('State', userProfile?.cusState ?? ''),
        _buildTableRow('Postcode', userProfile?.cusPostcode ?? ''),
        _buildTableRow('Country', userProfile?.cusCountry ?? ''),
        _buildTableRow('Address', userProfile?.cusAdd ?? ''),
      ],
    );
  }

  Widget _buildShippingAddress(UserProfileModel? userProfile) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: FlexColumnWidth(1.5),
        1: FlexColumnWidth(4),
      },
      children: [
        _buildTableRow('Name', userProfile?.shipName ?? ''),
        _buildTableRow('Phone', userProfile?.shipPhone ?? ''),
        _buildTableRow('City', userProfile?.shipCity ?? ''),
        _buildTableRow('State', userProfile?.shipState ?? ''),
        _buildTableRow('Postcode', userProfile?.shipPostcode ?? ''),
        _buildTableRow('Country', userProfile?.shipCountry ?? ''),
        _buildTableRow('Address', userProfile?.shipAdd ?? ''),
      ],
    );
  }

  TableRow _buildTableRow(String cellHead, String? cellData) {
    return TableRow(
      children: [
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '$cellHead:',
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(cellData ?? '', style: const TextStyle(fontSize: 20)),
          ),
        ),
      ],
    );
  }
}
