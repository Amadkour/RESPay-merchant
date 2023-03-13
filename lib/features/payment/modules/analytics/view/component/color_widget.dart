import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/res/extensions/strings_extension.dart';

class ColorWidget extends StatelessWidget {
  const ColorWidget({super.key, required this.colors, required this.onColorSelected, this.selectedColor});

  final List<String> colors;
  final ValueChanged<String> onColorSelected;
  final String? selectedColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: colors
          .map(
            (String e) => InkWell(
              onTap: () {
                onColorSelected(e);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(2),
                margin: const EdgeInsetsDirectional.only(end: 12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selectedColor == e ? Colors.black : Colors.white,
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: e.toColor().withOpacity(0.2),
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
