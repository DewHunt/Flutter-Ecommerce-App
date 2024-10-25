import 'package:ecommerce/data/models/user_profile_model.dart';
import 'package:ecommerce/presentation/state_holders/state_holders.dart';
import 'package:ecommerce/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:ecommerce/presentation/ui/screens/user_profile_screen.dart';
import 'package:ecommerce/presentation/ui/utils/utils.dart';
import 'package:ecommerce/presentation/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({
    super.key,
    required this.accessToken,
    required this.isUpdate,
  });

  final String accessToken;
  final bool isUpdate;

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _customerNameTEController =
      TextEditingController();
  final TextEditingController _customerCityTEController =
      TextEditingController();
  final TextEditingController _customerStateTEController =
      TextEditingController();
  final TextEditingController _customerPostcodeTEController =
      TextEditingController();
  final TextEditingController _customerCountryTEController =
      TextEditingController();
  final TextEditingController _customerPhoneTEController =
      TextEditingController();
  final TextEditingController _customerFaxTEController =
      TextEditingController();
  final TextEditingController _customerAddressTEController =
      TextEditingController();

  final TextEditingController _shippingNameTEController =
      TextEditingController();
  final TextEditingController _shippingCityTEController =
      TextEditingController();
  final TextEditingController _shippingStateTEController =
      TextEditingController();
  final TextEditingController _shippingPostcodeTEController =
      TextEditingController();
  final TextEditingController _shippingCountryTEController =
      TextEditingController();
  final TextEditingController _shippingPhoneTEController =
      TextEditingController();
  final TextEditingController _shippingAddressTEController =
      TextEditingController();

  final CompleteProfileController _completeProfileController =
      Get.find<CompleteProfileController>();
  final ReadProfileController _readProfileController =
      Get.find<ReadProfileController>();

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      _readProfileController.getProfileDetails(AuthController.accessToken!);
      UserProfileModel? userProfile = _readProfileController.userProfile;

      _customerNameTEController.text = userProfile?.cusName ?? '';
      _customerCityTEController.text = userProfile?.cusCity ?? '';
      _customerStateTEController.text = userProfile?.cusState ?? '';
      _customerPostcodeTEController.text = userProfile?.cusPostcode ?? '';
      _customerCountryTEController.text = userProfile?.cusCountry ?? '';
      _customerPhoneTEController.text = userProfile?.cusPhone ?? '';
      _customerFaxTEController.text = userProfile?.cusFax ?? '';
      _customerAddressTEController.text = userProfile?.cusAdd ?? '';

      _shippingNameTEController.text = userProfile?.shipName ?? '';
      _shippingCityTEController.text = userProfile?.shipCity ?? '';
      _shippingStateTEController.text = userProfile?.shipState ?? '';
      _shippingPostcodeTEController.text = userProfile?.shipPostcode ?? '';
      _shippingCountryTEController.text = userProfile?.shipCountry ?? '';
      _shippingPhoneTEController.text = userProfile?.shipPhone ?? '';
      _shippingAddressTEController.text = userProfile?.shipAdd ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            'Complete Profile',
            style: TextStyle(
              color: AppColors.themeColor,
            ),
          ),
          bottom: _buildTabBar(),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Form(
            key: _formKey,
            child: TabBarView(
              children: [
                _buildPersonalInformationForm(),
                _buildShippingAddressForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TabBar _buildTabBar() {
    return const TabBar(
      indicator: BoxDecoration(color: AppColors.themeColor),
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: Colors.white,
      labelStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      dividerColor: AppColors.themeColor,
      dividerHeight: 2,
      tabs: [
        Tab(text: 'Personal Information'),
        Tab(text: 'Shipping Address'),
      ],
    );
  }

  Widget _buildPersonalInformationForm() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _customerNameTEController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(hintText: 'Name'),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter Your Name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _customerCityTEController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(hintText: 'City'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _customerStateTEController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(hintText: 'State'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _customerPostcodeTEController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(hintText: 'Postcode'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _customerCountryTEController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(hintText: 'Country'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _customerPhoneTEController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(hintText: 'Phone'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _customerFaxTEController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(hintText: 'Fax'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _customerAddressTEController,
            maxLines: 4,
            decoration: const InputDecoration(hintText: 'Address'),
          ),
        ],
      ),
    );
  }

  Widget _buildShippingAddressForm() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _shippingNameTEController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(hintText: 'Shipping Name'),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter your shipping name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _shippingCityTEController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(hintText: 'Shipping City'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _shippingStateTEController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(hintText: 'Shipping State'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _shippingPostcodeTEController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(hintText: 'Shipping Postcode'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _shippingCountryTEController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(hintText: 'Shipping Country'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _shippingPhoneTEController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(hintText: 'Shipping Phone'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _shippingAddressTEController,
            maxLines: 4,
            decoration: const InputDecoration(hintText: 'Shipping Address'),
          ),
          const SizedBox(height: 16),
          GetBuilder<CompleteProfileController>(
              builder: (completeProfileController) {
            return Visibility(
              visible: !completeProfileController.inProgress,
              replacement: const CenteredCircularProgressIndicator(),
              child: ElevatedButton(
                onPressed: _onTapCompleteButton,
                child: const Text('Complete'),
              ),
            );
          }),
        ],
      ),
    );
  }

  Future<void> _onTapCompleteButton() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    Map<String, dynamic> requestData = {
      "cus_name": _customerNameTEController.text.trim(),
      "cus_add": _customerAddressTEController.text.trim(),
      "cus_city": _customerCityTEController.text.trim(),
      "cus_state": _customerStateTEController.text.trim(),
      "cus_postcode": _customerPostcodeTEController.text.trim(),
      "cus_country": _customerCountryTEController.text.trim(),
      "cus_phone": _customerPhoneTEController.text.trim(),
      "cus_fax": _customerFaxTEController.text.trim(),
      "ship_name": _shippingNameTEController.text.trim(),
      "ship_add": _shippingAddressTEController.text.trim(),
      "ship_city": _shippingCityTEController.text.trim(),
      "ship_state": _shippingStateTEController.text.trim(),
      "ship_postcode": _shippingPostcodeTEController.text.trim(),
      "ship_country": _shippingCountryTEController.text.trim(),
      "ship_phone": _shippingPhoneTEController.text.trim()
    };

    bool result = await _completeProfileController.completeProfile(
      widget.accessToken,
      requestData,
    );

    if (result) {
      bool readProfileResult =
          await _readProfileController.getProfileDetails(widget.accessToken);
      if (readProfileResult) {
        if (_readProfileController.isProfileCompleted) {
          if (widget.isUpdate) {
            Get.to(() => const UserProfileScreen());
          } else {
            Get.offAll(() => const MainBottomNavScreen());
          }
        }
      } else {
        if (mounted) {
          showSnackBarMessage(
            context,
            _readProfileController.errorMessage!,
            true,
          );
        }
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
          context,
          _completeProfileController.errorMessage!,
          true,
        );
      }
    }
    // Get.to(() => const OtpVerificationScreen(email: ''));
  }

  @override
  void dispose() {
    _customerNameTEController.clear();
    _customerCityTEController.clear();
    _customerStateTEController.clear();
    _customerPostcodeTEController.clear();
    _customerCountryTEController.clear();
    _customerPhoneTEController.clear();
    _customerAddressTEController.clear();
    _customerFaxTEController.clear();

    _shippingNameTEController.clear();
    _shippingCityTEController.clear();
    _shippingStateTEController.clear();
    _shippingPostcodeTEController.clear();
    _shippingCountryTEController.clear();
    _shippingPhoneTEController.clear();
    _shippingAddressTEController.clear();
    super.dispose();
  }
}
