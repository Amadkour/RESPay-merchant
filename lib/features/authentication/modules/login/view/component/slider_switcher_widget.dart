import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';

class SliderSwitcherWidget extends StatelessWidget {
  final double? fontSize;
  final double? sliderWidth;
  final double? sliderHeight;
  final int? selectedIndex;
  final List<String> items;
  final void Function(int index) onChangeIndex;

  const SliderSwitcherWidget(
      {super.key,
      required this.fontSize,
      required this.sliderHeight,
      this.sliderWidth,
      required this.selectedIndex,
      required this.items,
      required this.onChangeIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sliderWidth,
      height: sliderHeight,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(40)),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          ...List<Widget>.generate(
            items.length,
            (int index) => InkWell(
              key: ValueKey<int>(index),
              onTap: selectedIndex == index
                  ? null
                  : () {
                      onChangeIndex(index);
                    },
              child: Container(
                width: (sliderWidth! - 10) / items.length,
                height: sliderHeight,
                decoration: BoxDecoration(
                  color: selectedIndex == index ? AppColors.blackColor : Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Center(
                  child: AutoSizeText(
                    items[index],
                    style: TextStyle(
                        color: selectedIndex == index ? Colors.white : AppColors.blackColor,
                        fontWeight: FontWeight.w500,
                        fontSize: fontSize),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*SlideSwitcher(
      initialIndex: index!,
      onSelect: (int newIndex) {
        onChangeIndex(newIndex);
      },
      containerHeight: sliderHeight!,
      slidersColors: [AppColors.blackColor],
      containerColor: Colors.white,
      containerWight: sliderWidth!,
      indents: 5,
      children: [
        Text(
          'Phone Number',
          style: TextStyle(
              color: index == 0 ? Colors.white : AppColors.blackColor,
              fontWeight: FontWeight.w500,
              fontSize: fontSize),
        ),
        Text(
          'ID Number',
          style: TextStyle(
              color: index == 1 ? Colors.white : AppColors.blackColor,
              fontWeight: FontWeight.w500,
              fontSize: fontSize),
        ),
      ],
    );*/

// InkWell(
// onTap: index == 0
// ? () {
// onChangeIndex(1);
// }
// : null,
// child: Container(
// width: sliderWidth! / 2 - 10,
// height: sliderHeight,
// decoration: BoxDecoration(
// color: index == 1 ? AppColors.blackColor : Colors.white,
// borderRadius: BorderRadius.circular(40)),
// child: Center(
// child: Text(
// tr('id_number'),
// style: TextStyle(
// color: index == 1 ? Colors.white : AppColors.blackColor,
// fontWeight: FontWeight.w500,
// fontSize: fontSize),
// ),
// ),
// ),
// ),
