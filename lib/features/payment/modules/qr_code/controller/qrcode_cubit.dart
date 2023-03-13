import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/message.dart';

import 'package:res_pay_merchant/routes/routes_name.dart';

part 'qrcode_state.dart';

class QrcodeCubit extends Cubit<QrcodeState> {
  QrcodeCubit() : super(QrcodeInitial());
  final MobileScannerController controller = MobileScannerController();

  void onDetectScanner(Barcode barcode, {bool returnWithValue = false}) {
    if (barcode.rawValue != null) {
      bool flag = false;
      if (int.tryParse(barcode.rawValue!) != null) {
        if ((barcode.rawValue!.startsWith('05') && barcode.rawValue!.length == 10) ||
            (barcode.rawValue!.startsWith('+96605') && barcode.rawValue!.length == 14) ||
            (barcode.rawValue!.startsWith('96605') && barcode.rawValue!.length == 13)) {
          flag = true;
        }
        if (flag) {
          final String phoneNumber = barcode.rawValue!.startsWith('+96605')
              ? barcode.rawValue!.substring(4, 14)
              : (barcode.rawValue!.startsWith('96605')
                  ? barcode.rawValue!.substring(3, 13)
                  : barcode.rawValue!);

          if (returnWithValue) {
            CustomNavigator.instance.pop(result: phoneNumber);
          } else {
            CustomNavigator.instance.pushNamed(RoutesName.addRequest,
                arguments: <String, dynamic>{"phoneNumber": phoneNumber});
          }
        } else {
          MyToast('Please entre a valid number');
        }
      } else {
        MyToast('Scan a number only please');
      }
    }
  }
}
