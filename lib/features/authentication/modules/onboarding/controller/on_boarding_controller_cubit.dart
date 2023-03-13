import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:res_pay_merchant/core/constant/shared_orefrences_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/local_storage_service.dart';

part 'on_boarding_controller_state.dart';

class OnBoardingControllerCubit extends Cubit<OnBoardingControllerState> {
  OnBoardingControllerCubit([LocalStorageService? service]) : super(OnBoardingControllerInitial()) {
    _localStorageService = service ?? sl<LocalStorageService>();
  }

  int index = 0;
  late LocalStorageService _localStorageService;
  void onChangeIndex(int newIndex) {
    index = newIndex;
    emit(OnBoardingControllerChangeIndexState());
  }

  List<String> titleText = <String>[
    tr('easy_transaction'),
    tr('track_activity'),
    tr('secure_transaction'),
  ];

  List<String> firstText = <String>[
    tr('send_or_receive_any_transaction'),
    tr('track_income'),
    tr('maintain_security'),
  ];

  List<String> imageUrl = <String>[
    'assets/images/onboarding/onboarding-1.svg',
    'assets/images/onboarding/onboarding-2.svg',
    'assets/images/onboarding/onboarding-3.svg'
  ];

  Future<void> install() async {
    await _localStorageService.writeKey(appInstalled, true);
  }
}
