import 'package:ecommerce/data/models/review_model.dart';
import 'package:ecommerce/data/models/user_profile_model.dart';
import 'package:ecommerce/presentation/state_holders/state_holders.dart';
import 'package:ecommerce/presentation/ui/screens/create_review_screen.dart';
import 'package:ecommerce/presentation/ui/utils/utils.dart';
import 'package:ecommerce/presentation/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key, required this.productId});

  final int productId;

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  final ReviewListController _reviewListController =
      Get.find<ReviewListController>();
  final AuthController _authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _reviewListController.getReviewList(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Reviews'),
        leading: IconButton(
          onPressed: () {
            // Get.to(() => ProductDetailsScreen(productId: widget.productId));
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: GetBuilder<ReviewListController>(builder: (reviewListController) {
        if (reviewListController.inProgress) {
          return const CenteredCircularProgressIndicator();
        } else if (reviewListController.errorMessage != null) {
          return Center(
            child: Text(reviewListController.errorMessage!),
          );
        } else if (reviewListController.reviewList.isEmpty) {
          return const Center(
            child: Text("Reviews not found"),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildBodySection(reviewListController.reviewList),
            ),
            if (_authController.isLoggedInUser()) _buildFooterSection(),
          ],
        );
      }),
    );
  }

  Widget _buildBodySection(List<ReviewModel> reviewList) {
    return ListView.builder(
      itemCount: reviewList.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 5,
          color: Colors.white,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileSection(reviewList[index].profile),
                _buildReviewSection(reviewList[index].description),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileSection(UserProfileModel? profile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Card(
          color: Colors.grey.shade100,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              size: 25,
              color: Colors.grey.shade500,
              Icons.account_circle_outlined,
            ),
          ),
        ),
        const SizedBox(width: 5),
        Text(
          profile?.cusName ?? '',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    );
  }

  Widget _buildReviewSection(String? description) {
    return Text(
      '''$description''',
      textAlign: TextAlign.justify,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildFooterSection() {
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
          Text(
            'Reviews (${_reviewListController.reviewList.length})',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          ClipOval(
            child: SizedBox(
              width: 60,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(
                    () => CreateReviewScreen(productId: widget.productId),
                  );
                },
                child: const Icon(size: 30, Icons.add),
              ),
            ),
          )
        ],
      ),
    );
  }
}
