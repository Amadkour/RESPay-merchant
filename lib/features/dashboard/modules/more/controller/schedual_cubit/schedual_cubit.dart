import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/dialogs/main_dialog.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/providers/models/call_days_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/providers/models/get_time_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/providers/repos/scedual_repo.dart';

part 'schedual_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  ScheduleCubit() : super(ScheduleLoading(loadedDays: false, loadedTimes: false)) {
    init();
  }

  CallDaysModel? daysModel;
  GetTimeModel? timesModel;

  ///default values
  String selectedDay = '-1';
  int selectedTimeIndex = -1;
  bool? isSelect = true;

  Future<void> init() async {
    ///---------------get Available days
    (await ScheduleRepo().getDaysList()).fold((Failure l) {
      MyToast(l.errors.toString());
      emit(ScheduleFailure(l.errors.toString()));
    }, (ParentModel r) async {
      daysModel = r as CallDaysModel;
      selectedDay = daysModel!.days!.first.toString().split(' ').first;
      await getTimes(selectedDay);
    });
  }

  ///---------------get Available Times
  Future<void> getTimes(String day) async {
    emit(ScheduleLoading(loadedDays: true, loadedTimes: false));
    (await ScheduleRepo().getTimesList(day)).fold((Failure l) {
      MyToast(l.errors.toString());
      emit(ScheduleFailure(l.errors.toString()));
    }, (ParentModel r) {
      timesModel = r as GetTimeModel;
      emit(ScheduleLoading(loadedDays: true, loadedTimes: true));
    });
  }

  ///---------- choose the day
  Future<void> selectDay(String day) async {
    selectedDay = day;
    isSelect = daysModel!.isSelected;
    //to get available times of this selected day
    await getTimes(selectedDay);
  }

  Future<void> selectTime(int index) async {
    selectedTimeIndex = index;
    emit(ScheduleLoading(loadedDays: true, loadedTimes: true));
  }

  bool get enableButton => selectedDay != '-1' && selectedTimeIndex != -1;

  Future<void> setCall(BuildContext context) async {
    (await ScheduleRepo().makeCall(
            date: selectedDay, time: timesModel!.times![selectedTimeIndex].time!.split(' ').first))
        .fold((Failure l) => MyToast(l.errors.toString()), (Map<String, dynamic> r) async {
      timesModel = timesModel!..times![selectedTimeIndex].isBooked = true;

      MainDialog(
          imagePNG: 'assets/images/register_confirmation.png',
          imageHeight: 188,
          imageWidth: 260,
          dialogTitle: 'Congratulations!',
          dialogSupTitle: 'Successfully, booked a call!');
      await Future<void>.delayed(
        const Duration(
          seconds: 2,
        ),
      );
      clear();
      CustomNavigator.instance.pop(result: 'dialog');
      CustomNavigator.instance.pop(result: 'sheet');
    });
  }

  void clear() {
    selectedDay = '-1';
    selectedTimeIndex = -1;
    emit(ScheduleLoading(loadedDays: true, loadedTimes: true));
  }
}
