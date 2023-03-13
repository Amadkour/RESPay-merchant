import 'dart:io';
import 'package:document_file_save_plus/document_file_save_plus.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ShareService {
  Future<void> shareFile(Uint8List bytes, String fileExtension, {bool save = false}) async {
    final String name = "${DateTime.now().microsecondsSinceEpoch}.$fileExtension";

    if(save) {
      await DocumentFileSavePlus.saveFile(bytes, name, fileExtension);
    }
    else {
      final String filePath = "${(await getTemporaryDirectory()).path}/$name";

      final File file = File(filePath);

      file.writeAsBytesSync(bytes);
      await Share.shareXFiles(<XFile>[XFile(filePath)]);
    }
  }
}
