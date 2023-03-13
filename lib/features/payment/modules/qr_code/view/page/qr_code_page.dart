import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/features/payment/modules/qr_code/controller/qrcode_cubit.dart';

class QRCodePage extends StatelessWidget {
  final bool? returnWithValue;

  const QRCodePage({this.returnWithValue = false});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      scaffold: BlocProvider<QrcodeCubit>(
        create: (BuildContext context) => QrcodeCubit(),
        child: BlocBuilder<QrcodeCubit, QrcodeState>(
          builder: (BuildContext context, QrcodeState state) {
            final QrcodeCubit cubit = BlocProvider.of(context);
            return SafeArea(
              child: Material(
                color: Colors.black.withOpacity(0.7),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 17),
                  child: SizedBox(
                    height: context.height - 36,
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              CustomNavigator.instance.pop();
                            },
                            child: Text(
                              String.fromCharCode(Icons.close.codePoint),
                              style: TextStyle(
                                inherit: false,
                                color: Colors.white,
                                fontSize: 30.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: Icons.close.fontFamily,
                                package: Icons.close.fontPackage,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Scan QR',
                          style: largeHeadlineStyle,
                        ),
                        Text(
                          'Place the QR Code in the box',
                          style: white500Style,
                        ),
                        const Spacer(),
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              width: context.width * 0.7,
                              height: context.height * 0.4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15)),
                              child: MobileScanner(
                                onDetect: (Barcode barcode,
                                    MobileScannerArguments? args) {
                                  cubit.onDetectScanner(barcode,
                                      returnWithValue:
                                          returnWithValue ?? false);
                                },
                                controller: cubit.controller,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(
                          flex: 3,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
/*

CustomNavigator.instance.pushNamed(
                                                  context, RoutesName.otp,
                                                  arguments: () async {
                                                    CustomSuccessDialog(
                                                      context: context,
                                                      size: size,
                                                      onPressedFirstButton: () {
                                                        Navigator.of(context)
                                                            .pushAndRemoveUntil(
                                                          MaterialPageRoute<dynamic>(
                                                            builder:
                                                                (BuildContext context) =>
                                                                TransactionReceiptPage(
                                                                  amount: '1800',
                                                                  transactionType: 'QR Pay',
                                                                  transactionTitle:
                                                                  'Gift Sent!',
                                                                  from:
                                                                  Beneficiary(imageUrl: ''),
                                                                  to: Beneficiary(imageUrl: ''),
                                                                ),
                                                          ),
                                                              (Route<dynamic> route) {
                                                            return route.settings.name ==
                                                                "/dashboard";
                                                          },
                                                        );
                                                      },
                                                      onPressedSecondButton: () {
                                                       CustomNavigator.instance..pushNamedAndRemoveUntil(
                                                            context,
                                                            RoutesName.dashboard,
                                                                (Route<dynamic> route) =>
                                                            false);
                                                      },
                                                    );

*/
