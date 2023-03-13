import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';

class SliderCardWidget extends StatelessWidget {
  final void Function(double value) onChangeSliderValue;
  final double sliderValue;

  const SliderCardWidget(
      {required this.onChangeSliderValue, required this.sliderValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(vertical: 20, horizontal: context.width * 0.04),
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RichText(
              text: TextSpan(children: <TextSpan>[
            TextSpan(
              text: (sliderValue * 10).toInt().toStringAsFixed(2),
              style: TextStyle(
                  fontSize: context.width * 0.08,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackColor),
            ),
            TextSpan(
              text: tr('sar'),
              style: TextStyle(
                  fontSize: context.width * 0.04,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackColor),
            )
          ])),
          SizedBox(
            height: context.height * 0.12,
            child: Stack(
              children: <Widget>[
                Tooltip(
                  message: sliderValue.toString(),
                  child: SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 3,
                      thumbShape:
                          const RoundSliderThumbShape(enabledThumbRadius: 8),
                      showValueIndicator: ShowValueIndicator.always,
                      valueIndicatorColor: AppColors.blueColor2,
                      minThumbSeparation: 10,
                    ),
                    child: Slider(
                      max: 100,
                      value: sliderValue,
                      activeColor: AppColors.blueColor2,
                      inactiveColor: AppColors.lightBlue,
                      thumbColor: Colors.white,
                      label: (sliderValue * 10).toStringAsFixed(0),
                      onChanged: onChangeSliderValue,
                    ),
                  ),
                ),
                Positioned(
                  left: context.width * 0.035,
                  bottom: 0,
                  child: Padding(
                    padding: EdgeInsets.all(
                      context.width * 0.018,
                    ),
                    child: Row(
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: '|\n',
                                style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.greyColor),
                              ),
                              TextSpan(
                                text: '0',
                                style: TextStyle(
                                    fontSize: context.width * 0.03,
                                    color: AppColors.greyColor),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: context.width * 0.06),
                        ...List<Widget>.generate(
                          9,
                          (int index) => Row(
                            children: <Widget>[
                              Text(
                                '|\n',
                                style: TextStyle(
                                    fontSize: context.width * 0.02,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.greyColor),
                              ),
                              SizedBox(width: context.width * 0.065),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: '  |\n',
                                style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.greyColor),
                              ),
                              TextSpan(
                                text: '100',
                                style: TextStyle(
                                    fontSize: context.width * 0.03,
                                    color: AppColors.greyColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
