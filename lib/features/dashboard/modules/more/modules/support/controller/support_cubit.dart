import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/support/provider/repo/support_repo.dart';

part 'support_state.dart';

class SupportCubit extends Cubit<SupportState> {
  SupportRepository ?supportRepository;
  SupportCubit(this.supportRepository) : super(SupportInitial());
  TextEditingController supportController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String ?errorMessage;
  FocusNode firstNameFocus = FocusNode();
  FocusNode supportNameFocus = FocusNode();

  FocusNode emailFocus = FocusNode();

  GlobalKey<FormState> supportValidationFormKey = GlobalKey<FormState>();
  void updateState(){
    emit(SupportInitial());
  }
  void setCurrentFormKey(GlobalKey<FormState> value){
    supportValidationFormKey=value;
  }
  ///
  void reset(){
    supportController.clear();
    firstNameController.clear();
    emailController.clear();
    emit(SupportInitial());
  }
  Future<void>sendIssue() async{
    try{
      emit(SupportLoadingState());
      final Either<Failure, ParentModel> result = await supportRepository!.sendSupportRequest(
        input: <String, dynamic>{
          "full_name": firstNameController.text,
          "email": emailController.text,
          "message": supportController.text,
        },
      );
      result.fold((Failure l) {
        errorMessage=l.message;
        emit(SupportErrorState());
      }, (ParentModel r) {
        emit(SupportSentIssueDone());
      });
    }catch(e){
      emit(SupportErrorState());
    }

  }

  void resetSupportState(){
    emit(SupportInitial());
  }
  ///

  bool supportDataEnabledButton() {
    if(supportValidationFormKey.currentState!=null){
      return supportValidationFormKey.currentState!.validate();
    }
    else{
      return false;
    }

  }
}
