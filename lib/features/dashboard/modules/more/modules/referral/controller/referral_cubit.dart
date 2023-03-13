import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/referral/provider/model/referrals.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/referral/provider/repo/remote_api_repo.dart';
import 'package:url_launcher/url_launcher.dart';

part 'referral_state.dart';

class ReferralCubit extends Cubit<ReferralState> {
  ReferralCubit() : super(ReferralInitial()){
    inti();
  }

  double sunOfEarned=0;
  void inti(){
    getReferralData();
  }
  RemoteReferralApiRepo referralApiRepo =sl<RemoteReferralApiRepo>();
  ReferralModel? referral;

  Future<void> getReferralData() async{
    try{
      emit(ReferralLoading());
      (await referralApiRepo.getReferralUR()).fold(
              (Failure l) => MyToast(l.errors.toString()
          ),
              (ParentModel r) {
            referral=r as ReferralModel;
            sunOfEarned = referral!.referrals!.fold(0, (double i, Referrals el){
              return i;
            });
            emit(ReferralLoaded());
          });
    }catch(e){
      MyToast("Error when trying get referral data");
    }

  }



  final TextEditingController textEditingController =TextEditingController();

  Future<void> copy()async{

    final ClipboardData copiedText =ClipboardData(text: referral!.refCode);
    await Clipboard.setData(copiedText);

    await paste();
  }

  Future<void> paste() async {
    final ClipboardData? text =await Clipboard.getData('text/plain');
    if(text!=null){
      MyToast("${tr("code copied")} ${text.text}");
    }
  }
  List<Map<String,dynamic>> contacts =<Map<String,dynamic>>[

    <String,dynamic>{
      "url":"assets/images/referral/mail.svg",
      "name":"email"
    },
    <String,dynamic>{
      "url":"assets/images/referral/facebook.svg",
      "name":"Facebook"
    },
    <String,dynamic>{
      "url":"assets/images/referral/whatsapp.png",
      "name":"Whatsapp"
    },
    <String,dynamic>{
      "url":"assets/images/referral/twitter.svg",
      "name":"twitter"
    }
  ];

  Future<void> launchCurrentUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }
}
