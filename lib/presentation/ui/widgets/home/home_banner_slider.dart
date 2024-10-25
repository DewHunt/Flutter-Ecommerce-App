import 'package:ecommerce/presentation/state_holders/slider_list_controller.dart';
import 'package:ecommerce/presentation/ui/utils/utils.dart';
import 'package:ecommerce/presentation/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeBannerSlider extends StatefulWidget {
  const HomeBannerSlider({
    super.key,
  });

  @override
  State<HomeBannerSlider> createState() => _HomeBannerSliderState();
}

class _HomeBannerSliderState extends State<HomeBannerSlider> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SliderListController>(
      builder: (sliderListController) {
        return Visibility(
          visible: !sliderListController.inProgress,
          replacement: const SizedBox(
            height: 192,
            child: CenteredCircularProgressIndicator(),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: _buildCarouselView(sliderListController),
              ),
              const SizedBox(height: 8),
              _buildCarouselDots(sliderListController),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCarouselView(SliderListController sliderListController) {
    return CarouselView(
      itemExtent: MediaQuery.sizeOf(context).width,
      shrinkExtent: 200,
      itemSnapping: true,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      children: List.generate(
        sliderListController.sliderList.length,
        (int index) {
          return Container(
            decoration: BoxDecoration(
              color: AppColors.themeColor,
              image: DecorationImage(
                image: NetworkImage(
                  sliderListController.sliderList[index].image ?? '',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: _buildSliderInfo(sliderListController, index),
          );
        },
      ),
    );
  }

  Widget _buildSliderInfo(
      SliderListController sliderListController, int index) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSliderTitle(sliderListController, index),
          const SizedBox(height: 16),
          _buildSliderButton()
        ],
      ),
    );
  }

  Widget _buildSliderTitle(
      SliderListController sliderListController, int index) {
    return Text(
      sliderListController.sliderList[index].price ?? '',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
    );
  }

  Widget _buildSliderButton() {
    return SizedBox(
      width: 150,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.themeColor,
        ),
        onPressed: () {},
        child: const Text('Buy Now'),
      ),
    );
  }

  Widget _buildCarouselDots(SliderListController sliderListController) {
    return ValueListenableBuilder(
      valueListenable: _selectedIndex,
      builder: (context, currentIndex, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < sliderListController.sliderList.length; i++)
              Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.only(right: 4),
                decoration: BoxDecoration(
                  color: currentIndex == i ? AppColors.themeColor : null,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                ),
              ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _selectedIndex.dispose();
    super.dispose();
  }
}
