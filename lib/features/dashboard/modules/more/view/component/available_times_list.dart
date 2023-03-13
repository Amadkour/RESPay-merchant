import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/controller/schedual_cubit/schedual_cubit.dart';

class AvailableTimesList extends StatelessWidget {
  const AvailableTimesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleCubit, ScheduleState>(
      builder: (BuildContext context, ScheduleState state) {
        final ScheduleCubit scheduleCubit = sl<ScheduleCubit>();
        if (state is ScheduleFailure) {
          return ErrorWidget(state.error);
        }
        if (state is ScheduleLoading && !state.loadedTimes) {
          return const Center(
            child: NativeLoading(
              size: 20,
            ),
          );
        }
        if (state is ScheduleLoading && state.loadedTimes) {
          return SizedBox(
            height: 36,
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  width: 12,
                );
              },
              itemCount: scheduleCubit.timesModel!.times!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  key: Key('time_check_key$index'),
                  onTap: () {
                    /// to check if selected a new date
                    if (scheduleCubit.selectedTimeIndex != index) {
                      scheduleCubit.selectTime(index);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: scheduleCubit.timesModel!.times![index].isBooked!
                            ? const Color(0xffF9F9F9).withOpacity(0.5)
                            : (const Color(0xffF9F9F9)),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: scheduleCubit.timesModel!.times![index].isBooked!
                                ? const Color(0xffD9D9D9)
                                : scheduleCubit.selectedTimeIndex == index
                                    ? const Color(0xff158CEA)
                                    : const Color(0xffC7C8CD))),
                    height: 36 * 0.7,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      alignment: Alignment.center,
                      child: AutoSizeText(
                        scheduleCubit.timesModel!.times![index].time!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: scheduleCubit.timesModel!.times![index].isBooked!
                              ? AppColors.blackColor.withOpacity(0.5)
                              : (AppColors.blackColor),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return const Center(
            child: NativeLoading(),
          );
        }
      },
    );
  }
}
