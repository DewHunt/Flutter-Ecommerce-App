import 'package:ecommerce/presentation/ui/utils/utils.dart';
import 'package:flutter/material.dart';

class SizePicker extends StatefulWidget {
  const SizePicker({
    super.key,
    required this.sizes,
    required this.onSizeSelected,
  });

  final List<String> sizes;
  final Function(String) onSizeSelected;

  @override
  State<SizePicker> createState() => _SizePickerState();
}

class _SizePickerState extends State<SizePicker> {
  late String _selectedSize = widget.sizes.first;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Size',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          children: [
            ...widget.sizes.map((size) {
              return GestureDetector(
                onTap: () {
                  _selectedSize = size;
                  widget.onSizeSelected(size);
                  setState(() {});
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: _selectedSize == size
                          ? AppColors.themeColor
                          : Colors.grey,
                    ),
                    color: _selectedSize == size ? AppColors.themeColor : null,
                  ),
                  child: Text(
                    size,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _selectedSize == size ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ],
    );
  }
}
