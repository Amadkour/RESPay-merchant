import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/constants.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/controller/beneficiary_cubit.dart';
import 'package:res_pay_merchant/features/payment/view/component/history_icon.dart';
import 'package:res_pay_merchant/features/search/components/build_search_bar.dart';

class CustomAppBarWithSearchBar extends StatelessWidget {
  const CustomAppBarWithSearchBar({super.key,required this.serviceType});

  final ServiceType serviceType;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: InkWell(
        onTap: () {
          CustomNavigator.instance.pop();
        },
        child: Container(
            margin:  const EdgeInsets.all(18),
            child: isArabic ? rightArrow():leftArrow()
        ),
      ),
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      title: BlocProvider<BeneficiaryCubit>.value(
        value: sl<BeneficiaryCubit>(),
        child: BlocBuilder<BeneficiaryCubit,BeneficiaryState>(
          builder: (BuildContext context, BeneficiaryState state) {
            return SearchBar(
                onClear: () {
                  sl<BeneficiaryCubit>().resetSearchBar(serviceType);
                },
                showClear: sl<BeneficiaryCubit>().searchBarController.text.isEmpty,
                hintText: "Search name or address",
                onChanged: (String value){
                  sl<BeneficiaryCubit>().filterByNameUsingEnteredTextInSearchBar(value,serviceType);
                }
                ,controller: sl<BeneficiaryCubit>().searchBarController
            );
          },
        ),
      ),
      actions: const <Widget>[
        HistoryIconWidget(),
        SizedBox(width: 20,)
      ],
    );
  }
}
//in english lang
SvgPicture leftArrow() => SvgPicture.asset("assets/icons/back.svg");

//in arabic lang
RotatedBox rightArrow() => RotatedBox(quarterTurns: 2 ,child: SvgPicture.asset("assets/icons/back.svg"));
