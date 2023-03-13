import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/container_with_shadow_widget.dart';

class BankTransferPage extends StatelessWidget {
  const BankTransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBarWidget: MainAppBar(title: tr('add_new')),
      scaffold: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 24,
            left: 20,
            right: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MyImage.svgAssets(
                    url: "assets/icons/deposit/bank_transfer_icon.svg",
                    width: 50,
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.greenColor,
                    ),
                  ),
                  MyImage.svgAssets(
                    url: "assets/icons/deposit/bank_transfer_icon.svg",
                    width: 50,
                    height: 50,
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Text(
                      tr('bank_transfer'),
                      style: header5Style,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 42, left: 42, right: 42),
                    child: Text(
                      tr('bank_transfer_description'),
                      textAlign: TextAlign.center,
                      style: bodyStyle,
                    ),
                  ),
                ],
              ),
              Text(
                tr('select_partner'),
                style: bodyStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              ContainerWithShadow(
                padding: EdgeInsets.zero,
                margin: const EdgeInsets.only(top: 20),
                child: ListTile(
                  leading: MyImage.svgAssets(
                    url: "assets/icons/deposit/rajhi_bank.svg",
                    width: 40,
                    height: 40,
                  ),
                  title: Text(
                    "Alrajhi Bank",
                    style: paragraphStyle,
                  ),
                  subtitle: const Text("0000-0000-0000-0000"),
                  trailing: InkWell(
                    onTap: () async {
                      await Clipboard.setData(
                          const ClipboardData(text: "0000-0000-0000-000"));
                      MyToast(
                        'copied_to_clipboard',
                        background: AppColors.greenColor,
                      );
                    },
                    child: MyImage.svgAssets(
                      url: "assets/icons/deposit/copy.svg",
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              ),
              ContainerWithShadow(
                padding: EdgeInsets.zero,
                margin: const EdgeInsets.only(top: 20),
                child: ListTile(
                  leading: MyImage.assets(
                    url: "assets/icons/deposit/anb_bank.png",
                    width: 40,
                    height: 40,
                  ),
                  title: Text(
                    "ANB Bank",
                    style: paragraphStyle,
                  ),
                  subtitle: const Text("0000-0000-0000-0000"),
                  trailing: InkWell(
                    onTap: () async {
                      await Clipboard.setData(
                          const ClipboardData(text: "0000-0000-0000-000"));
                      MyToast(
                        'copied_to_clipboard',
                        background: AppColors.greenColor,
                      );
                    },
                    child: MyImage.svgAssets(
                      url: "assets/icons/deposit/copy.svg",
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
