import 'dart:typed_data';

import 'package:res_pay_merchant/core/res/utils/pdf_service.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/features/payment/view/component/receipt/provider/model/receipt_model.dart';

import 'package:screenshot/screenshot.dart';

class ScreenShotService {
  final ScreenshotController controller = ScreenshotController();

  Future<Uint8List?> _convertWidgetToImage() async {
    final Uint8List? bytes = await controller.capture();
    return bytes;
  }

  Future<Uint8List?> _convertWidgetToPDf(ReceiptModel receiptModel) async {
    final Future<Uint8List> pdf = sl<PdfService>().generate(receiptModel);
    return pdf;
  }

  Future<Uint8List?> convertToBytes(String ext, {ReceiptModel? receiptModel}) {
    if (receiptModel != null) {
      return _convertWidgetToPDf(receiptModel);
    }
    return _convertWidgetToImage();
  }
}
