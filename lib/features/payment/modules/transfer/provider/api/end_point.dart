import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';

 String createTransferApi = "/${BaseUrlModules.wallet.name}/transfer/make";
 String loadTransferOptions = "/${BaseUrlModules.wallet.name}/transfer/list";
 String createNewBeneficiary = "/${BaseUrlModules.authentication.name}/beneficiaries/add";
 String loadBeneficiaries = "/${BaseUrlModules.authentication.name}/beneficiaries/list";
 String favouriteToggleEndPoint = "/${BaseUrlModules.authentication.name}/beneficiaries/favorite/toggle";
