import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({
    super.key,
    required this.colors,
    required this.onColorSelected,
  });

  final List<Color> colors;
  final Function(Color) onColorSelected;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late Color _selectedColor = widget.colors.first;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Colors',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          children: [
            ...widget.colors.map((color) {
              return GestureDetector(
                onTap: () {
                  _selectedColor = color;
                  widget.onColorSelected(color);
                  setState(() {});
                },
                child: CircleAvatar(
                  backgroundColor: color,
                  child: _selectedColor == color
                      ? const Icon(
                          Icons.check_outlined,
                          color: Colors.white,
                        )
                      : null,
                ),
              );
            }),
          ],
        ),
      ],
    );
  }
}
