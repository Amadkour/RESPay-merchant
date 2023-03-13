import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/controller/more%20cubit/more_state.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/controller/schedual_cubit/schedual_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/view/component/available_times_list.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/view/component/days_list.dart';

class ScheduleCallBody extends StatelessWidget {
  const ScheduleCallBody({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      backgroundColor: Colors.transparent,
      scaffold: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22)
        ),
        padding: const EdgeInsets.only(top: 16, right: 20, left: 20),
        child: BlocProvider<ScheduleCubit>.value(
          value: sl<ScheduleCubit>(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Container(
                    width: 64,
                    decoration: BoxDecoration(
                      color: AppColors.bottomSheetIconColor,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                    ),
                    height: 5,
                  ),
                ),
                const SizedBox(height: 25,),
                AutoSizeText(tr("Schedule call"),
                    style: TextStyle(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 16)
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: AutoSizeText(
                      tr("Please choose call scheduling to avoid full queues"),
                      style: const TextStyle(
                          color: Color(0xff5A6367),
                          fontWeight: FontWeight.w400,
                          fontSize: 14)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 13),
                  child: AutoSizeText(tr("Select call date(optional)"),
                      style: TextStyle(
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 17),
                  child: DaysList(),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 11),
                  child: AutoSizeText(tr("Select call hours"),
                      style: TextStyle(
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 12)
                  ),
                ),
                const AvailableTimesList(),
                BlocBuilder<ScheduleCubit, ScheduleState>(
                  builder: (BuildContext context, ScheduleState state) {
                    final ScheduleCubit controller = context.read<
                        ScheduleCubit>();
                    if (state is SetCallEnd) {
                      Navigator.pop(context);
                    }
                    return Center(
                      child: LoadingButton(
                        key: setCallKey,
                        enable: controller.enableButton,
                        isLoading: state is ScheduleLoadingStat,
                        onTap: (){
                          controller.setCall(context);
                        },
                        title: tr("Set Call"),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
