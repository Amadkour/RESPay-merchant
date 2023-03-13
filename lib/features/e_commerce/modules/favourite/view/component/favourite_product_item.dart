import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/dialogs/confitm_cancel_dialog.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/favourite/controller/favourite_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/favourite/provider/models/favourite_model.dart';

class FavoriteProductItem extends StatelessWidget {
  const FavoriteProductItem({super.key, required this.productModel});
  final FavoriteItemModel productModel;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 90,
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 12),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Row(
          children: <Widget>[
            MyImage.network(
              width: 90,
              url: productModel.image!.isNotEmpty ? productModel.image![0] : "",
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "${productModel.price} ${tr("SAR")}",
                        style: TextStyle(
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ),
                    BlocBuilder<FavoriteCubit, FavoriteState>(
                      buildWhen: (FavoriteState previous,
                              FavoriteState current) =>
                          sl<FavoriteCubit>().buildWhenCondition(productModel),
                      builder: (BuildContext context, FavoriteState state) {
                        if (state is FavoriteCubitItemUpdateStateLoading) {
                          return const SizedBox.square(
                              dimension: 20,
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ));
                        }
                        return InkWell(
                          onTap: () {
                            ConfirmCancelDialog(
                                context: context,
                                title:
                                    tr("are_you_sure_you_want_delete_product"),
                                onConfirm: () async {
                                  sl<FavoriteCubit>()
                                      .setCurrentProduct(productModel.uuid!);
                                  sl<FavoriteCubit>()
                                      .removeFromFavorite(productModel.uuid!);
                                });
                          },
                          child: MyImage.svgAssets(
                            width: 14,
                            height: 14,
                            url: "assets/icons/e_commerce/editicon.svg",
                          ),
                        );
                      },
                    )
                  ],
                )),
                Expanded(
                    child: Text(
                  productModel.name!,
                  style: const TextStyle(
                      color: Color(0xff5A6367),
                      fontWeight: FontWeight.w500,
                      fontSize: 12),
                )),
                Expanded(
                    child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Html(
                          data: productModel.description ?? """""",
                          style: <String, Style>{
                            "p": Style(
                                color: AppColors.blackColor,
                                fontSize: FontSize(12),
                                fontWeight: FontWeight.w500),
                          }),
                    ),
                  ],
                )),
              ],
            ))
          ],
        ));
  }
}
