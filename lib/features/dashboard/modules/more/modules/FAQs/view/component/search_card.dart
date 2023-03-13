
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/FAQs/controllers/faq_cubit.dart';
import 'package:res_pay_merchant/features/search/components/build_search_bar.dart';

class SearchCard extends StatelessWidget{
  final String userName;
  final FaqCubit faqCubit;
 final void Function(String) search;
  const SearchCard(this.userName, this.search,this.faqCubit);

  @override
  Widget build(BuildContext context) {
         return ColoredBox(
          color: Colors.white,
           child: Column(
             children: <Widget>[
               Text(
                 'Hi $userName,',
                 style: TextStyle(
                   color: AppColors.blackColor,
              fontWeight: FontWeight.w500,
              fontSize: 12,
              fontFamily: 'semiBold'
                 ),
               ),
               const SizedBox(height: 8,),
               Text(
                 tr('need_help'),
                 style: TextStyle(
                     color: AppColors.blackColor,
                     fontWeight: FontWeight.w500,
                     fontSize: 16,
                     fontFamily: 'semiBold'
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.all(20),
                 child: SearchBar(
                   backGroundColor: AppColors.backgroundColor,
                     hintText: "search",
                     controller: faqCubit.searchBarController,
                     onChanged: search,
                     onClear: () {
                       faqCubit.resetSearchBar();
                     },
                     showClear: faqCubit.searchBarController.text.isEmpty
                 ),
               )
             ],
           )
         ) ;
 }

}
