import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:res_pay_merchant/core/res/utils/screen_shot_service.dart';
import 'package:res_pay_merchant/core/res/utils/share_service.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/features/payment/view/component/receipt/provider/model/receipt_model.dart';

part 'receipt_state.dart';

class ReceiptCubit extends Cubit<ReceiptState> {
  ReceiptCubit() : super(ReceiptInitial());

  Future<void> getReceipt(String fileExt,
      {bool save = false, ReceiptModel? receiptModel}) async {
    final Uint8List? path = await sl<ScreenShotService>()
        .convertToBytes(fileExt, receiptModel: receiptModel);
    if (path != null) {
      sl<ShareService>().shareFile(path, fileExt, save: save);
    }
  }
}
