import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/dialogs/custom_success_dialog.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/amount_text_field.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/notes_textfield.dart';
import 'package:res_pay_merchant/features/payment/modules/qr_code/view/page/qr_transaction_receipt_page.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/beneficary_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/container_with_shadow_widget.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/shared/drop_down_list.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_to/beneficiary_item.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class QRCodeTransferMoneyPage extends StatelessWidget {
  const QRCodeTransferMoneyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBarWidget: const MainAppBar(title: 'Transfer Money'),
      scaffold: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ContainerWithShadow(
              padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 20),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: BeneficiaryItem(
                imageRadius: 23,
                verticalPadding: 12,
                boolShowType: true,
                isFavoriteIconExists: false,
                beneficiary: Beneficiary(
                  firstName: 'Ahmed',
                  lastName: 'Hasan',
                  accountNumber: '+628 000 - 0000 - 0000',
                  isFavorite: true,
                ),
              ),
            ),
            Container(
              height: context.height * 0.5,
              width: context.width,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: <Widget>[
                  AutoSizeText(
                    'Enter Amount',
                    style: TextStyle(color: AppColors.darkGrayColor),
                  ),
                  SizedBox(
                    width: context.width * 0.5,
                    child: const AmountTextField(initialText: '182.00'),
                  ),
                  SizedBox(
                    height: context.height * 0.03,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: AutoSizeText(
                      'Select Category',
                      style: TextStyle(
                          color: AppColors.darkGrayColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const _CustomDropDown(),
                  SizedBox(
                    height: context.height * 0.03,
                  ),
                  NotesTextfield(onChanged: (String value) {})
                ],
              ),
            ),
            SizedBox(
              height: context.height * 0.07,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: LoadingButton(
                title: tr('send'),
                onTap: () async {
                  await CustomSuccessDialog.instance.show(
                    context: context,
                    onPressedSecondButton: () {
                      CustomNavigator.instance.pushNamedAndRemoveUntil(
                        RoutesName.authDashboard,
                        (Route<dynamic> value) => false,
                      );
                    },
                    onPressedFirstButton: () {
                      CustomNavigator.instance.push(
                          routeWidget: QRTransactionReceiptPage(
                        transactionTitle: "QR Pay",
                        from: const <String, dynamic>{
                          'name': 'AHMED HASAN',
                          'uuid': '0000 - 0000 - 0000 - 0000'
                        },
                        to: Beneficiary(
                            firstName: 'MAULANA',
                            lastName: '',
                            accountNumber: '0000 - 0000 - 0000 - 0000',
                            imageUrl:
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgIUF7SE6CROioPfFm3jxwN5cPMxD_MobRdw&usqp=CAU',
                            uuid: '0000 - 0000 - 0000 - 0000'),
                      ));
                    },
                  );
                },
                isLoading: false,
                topPadding: 0,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _CustomDropDown extends StatelessWidget {
  const _CustomDropDown();

  @override
  Widget build(BuildContext context) {
    return CustomDropDownListWithValidator(
      onChanged: (dynamic value) {},
      color: AppColors.backgroundColor,
      backgroundColor: AppColors.backgroundColor,
      textValue: 'qr_pay',
      list: const <DropdownMenuItem<dynamic>>[
        DropdownMenuItem<dynamic>(
          value: 'qr_pay',
          child: Text('QR Pay'),
        ),
        DropdownMenuItem<dynamic>(
          value: 'supermarket',
          child: Text('Supermarket'),
        ),
      ],
      isFlagExist: true,
      itemToString: 'qr_pay',
    );
  }
}
