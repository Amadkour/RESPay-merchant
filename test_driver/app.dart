import 'package:flutter_driver/driver_extension.dart';
import 'package:res_pay_merchant/main.dart' as app;

Future<void> main() async {
  enableFlutterDriverExtension();
  await app.main();
}
