import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';

import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/alternative_widgets/empty_widget.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/controller/schedual_cubit/schedual_cubit.dart';

class DaysList extends StatelessWidget {
  const DaysList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<ScheduleCubit, ScheduleState>(
        builder: (BuildContext context, ScheduleState state) {
          final ScheduleCubit controller = sl<ScheduleCubit>();
          if (state is ScheduleFailure) {
            return ErrorWidget(state.error);
          }
          if (state is ScheduleLoading && !state.loadedDays) {
            return const Center(
              child: NativeLoading(),
            );
          }
          if (state is ScheduleLoading && state.loadedDays) {
            if (controller.daysModel!.days!.isEmpty) {
              return EmptyWidget(
                height: 0,
                message: tr("No Dates Yet"),
              );
            } else {
              return SizedBox(
                height: 88,
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    width: 12,
                  ),
                  itemCount: controller.daysModel!.days!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        key: Key('day_check_key$index'),

                      onTap: () {
                        /// tapped day
                        final String selectedDay= controller.daysModel!.days![index].toString().split(' ').first;
                         /// to check if selected a new date
                        if(controller.selectedDay!=selectedDay) {
                          controller.selectDay(selectedDay);
                        }

                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xffF6F6F6),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color:
                                controller.daysModel!.days![index].toString().startsWith(controller.selectedDay)  ?const Color(0xff158CEA):const Color(0xffC7C8CD)
                                    // const Color(0xff158CEA):const Color(0xffC7C8CD)
                                    // controller.daysModel==true
                                    //     ? controller.daysModel==controller.daysModel!.days![index]?const Color(0xff158CEA):const Color(0xffC7C8CD)
                                    //     :
                                   //const Color(0xffC7C8CD)
                            )),
                        height: 88,
                        width: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 77 * 0.3,
                              child: FittedBox(
                                child: AutoSizeText(
                                  DateFormat.d().format(
                                          controller.daysModel!.days![index]),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: AppColors.blackColor),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 77 * 0.3,
                              child: FittedBox(
                                child: AutoSizeText(
                                  DateFormat.MMM().format(
                                      controller.daysModel!.days![index]),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 24,
                                      color: AppColors.blackColor),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color:
                                      const Color(0xff158CEA).withOpacity(0.2),
                                  borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(5),
                                      bottomLeft: Radius.circular(5))),
                              alignment: Alignment.center,
                              width: double.infinity,
                              height: 77 * 0.3,
                              child: AutoSizeText(
                                  DateFormat.EEEE().format(
                                      controller.daysModel!.days![index]),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.w700)),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          } else {
            return const Center(
              child: NativeLoading(),
            );
          }
        },
      );

  }
}
