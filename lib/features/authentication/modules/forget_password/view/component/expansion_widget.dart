import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';


/// Custom Widget for expanding phone number, identity id and email cards part of [ForgetPasswordPage]

class ExpansionWidget extends StatelessWidget {
  final String? imageUrl;
  final String? title;
  final void Function() changeExpansionState;
  final bool isExpanded;
  final Widget? expansionImage;
  final Widget? widget;

  const ExpansionWidget({
    super.key,
    this.imageUrl,
    required this.title,
    required this.changeExpansionState,
    required this.isExpanded,
    this.expansionImage,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ExpansionPanelList(
        expansionCallback: (int index, bool value) {
          changeExpansionState();
        },
        children: <ExpansionPanel>[
          ExpansionPanel(
              headerBuilder: (BuildContext context, bool value) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 8, vertical: isExpanded ? 0 : 24),
                  child: Row(
                    children: <Widget>[
                      expansionImage ??
                          MyImage.svgAssets(
                            url: imageUrl,
                            width: context.width * 0.08,
                            height: context.width * 0.08,
                          ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        title!,
                        style: TextStyle(
                            fontSize: context.width * 0.04,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                );
              },
              body: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Divider(
                      color: AppColors.borderColor,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    widget!
                  ],
                ),
              ),
              isExpanded: isExpanded)
        ],
      ),
    );
  }
}
