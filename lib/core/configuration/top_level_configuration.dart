import 'package:res_pay_merchant/routes/routes_name.dart';

String verificationMethodPath = RoutesName.transactionOtp;
String startRoute = RoutesName.login;
// String type = 'test';
String type = 'review';
bool showRESPayButton = false;
String otp = '';
String defaultImage = 'assets/images/logo.png';

///This flag prevent base page
///from redirect to pin code screen
///if user open face id and wait for 25 seconds
bool isLocalAuth = false;
bool userOldServer = false;
bool isSecure = false;
bool showDevicePreview = false;
bool showLocalBeneficiaryInRequestAndGift = true;
