import 'package:ecommerce/presentation/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        TextButton(
          onPressed: onTap,
          child: Text(
            'See All',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.themeColor,
                ),
          ),
        )
      ],
    );
  }
}
