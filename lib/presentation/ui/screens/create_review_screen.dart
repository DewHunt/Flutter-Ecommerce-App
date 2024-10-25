import 'package:ecommerce/presentation/state_holders/state_holders.dart';
import 'package:ecommerce/presentation/ui/screens/reviews_screen.dart';
import 'package:ecommerce/presentation/ui/utils/snack_message.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

const List<String> ratingList = ['1', '2', '3', '4', '5'];

class CreateReviewScreen extends StatefulWidget {
  const CreateReviewScreen({super.key, required this.productId});

  final int productId;

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  final TextEditingController _reviewTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String ratingValue = ratingList.last;

  final CreateReviewController _createReviewController =
      Get.find<CreateReviewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Create Review'),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButtonFormField(
                  value: ratingValue,
                  hint: const Text('Choose your Rating'),
                  items: ratingList.map<DropdownMenuItem<String>>(
                    (String textValue) {
                      return DropdownMenuItem<String>(
                        value: textValue,
                        child: Text(textValue),
                      );
                    },
                  ).toList(),
                  onChanged: (String? newValue) {
                    ratingValue = newValue!;
                    setState(() {});
                    debugPrint(ratingValue);
                  },
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Please select your rating';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _reviewTEController,
                  maxLines: 10,
                  decoration: const InputDecoration(
                    hintText: 'Write your review',
                  ),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Write your review';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                GetBuilder<CreateReviewController>(
                    builder: (createReviewController) {
                  return Visibility(
                    visible: !createReviewController.inProgress,
                    child: ElevatedButton(
                      onPressed: _onTapCreateReviewButton,
                      child: const Text('Complete'),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTapCreateReviewButton() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    Map<String, dynamic> requestData = {
      "description": _reviewTEController.text.trim(),
      "product_id": widget.productId,
      "rating": ratingValue
    };

    final bool result = await _createReviewController.createReview(requestData);

    if (result) {
      Get.off(() => ReviewsScreen(productId: widget.productId));
    } else {
      if (mounted) {
        showSnackBarMessage(
          context,
          _createReviewController.errorMessage!,
          true,
        );
      }
    }
  }

  @override
  void dispose() {
    _reviewTEController.dispose();
    super.dispose();
  }
}
