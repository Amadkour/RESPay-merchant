import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';

import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/provider/models/cart_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/provider/models/promotions_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/provider/repo/remote_cart_repo.dart';

import 'package:res_pay_merchant/core/res/theme/colors.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  RemoteCartRepo? remoteCartRepo;

  CartCubit(this.remoteCartRepo) : super(CartInitial());
  String promoCodeMessage = "";
  String? currentProduct = "";
  FocusNode promoCodeFocusNode = FocusNode();

  void resetCartAndPromoCode() {
    cartModel = null;
    promotionTextFieldController.clear();
    promoCodeMessage = "";
  }

  void resetPromoCode() {
    promotionTextFieldController.clear();
    isPromotionAlreadyExist = false;
    promoCodeMessage = "";
  }

  bool get isPromoCodeApplied => isPromotionAlreadyExist;

  TextEditingController promotionTextFieldController = TextEditingController();
  bool isPromotionAlreadyExist = false;

  // Future<void> setIsPromotion() async {
  //   currentProduct = "-1";
  //   if (promotionTextFieldController.text.isNotEmpty) {
  //     if (isPromoCodeApplied) {
  //       await removePromotion();
  //     } else {
  //       await addPromotion();
  //     }
  //   } else {
  //     MyToast(tr("Promo code field is empty"));
  //   }
  // }

  Future<bool> setIsPromotion(String shopUUID) async {
    if (promotionTextFieldController.text.isNotEmpty) {
      if (isPromoCodeApplied) {
        await removePromotion(shopUUID: shopUUID);
      } else {
        await addPromotion(shopUUID: shopUUID);
      }
    } else {
      return false;
    }
    return true;
  }

  GlobalKey<FormState> promoCodeFormKey = GlobalKey<FormState>();
  void setCurrentProduct(String newValue) {
    currentProduct = newValue;
    emit(CartInitial());
  }

  CartModel? cartModel;
  PromotionsModel? promotionsModel;
  bool showSummary = false;

  bool conditionToRebuild(String productModel) {
    return currentProduct == productModel || currentProduct == "";
  }

  Future<void> addToCart(String productUUID) async {
    try {
      emit(ItemAdditionInLoading());
      (await remoteCartRepo!
              .addProductToCart(productUUID, cartModel!.cart!.shopSlug ?? ""))
          .fold((Failure l) {
        if (l.errors.isNotEmpty) {
          MyToast(
            l.errors['error'] as String,
            background: AppColors.greenColor,
          );
        }
        emit(CartError());
      }, (ParentModel r) async {
        cartModel = r as CartModel;
        MyToast(
          tr('product_added_to_cart'),
          background: AppColors.greenColor,
        );
        emit(CartLoaded());
      });
    } catch (e) {
      emit(CartError());
    }
  }

  Future<void> getCartProducts(String shopUUID) async {
    emit(CartLoading());
    cartModel = null;
    (await remoteCartRepo!.getCartProducts(shopUUID)).fold((Failure l) {
      cartModel = CartModel(cart: Cart(items: <CartItemModel>[]));
      emit(CartError());
    }, (ParentModel r) {
      isPromotionAlreadyExist = false;
      cartModel = r as CartModel;
      emit(CartLoaded());
    });
  }

  Future<void> removePromotion(
      {bool forTest = false, required String shopUUID}) async {
    emit(CartPromotionsLoading());
    (await remoteCartRepo!.removePromotions(
            promoCode: promotionTextFieldController.text != ""
                ? promotionTextFieldController.text
                : "d"))
        .fold((Failure l) {
      promoCodeMessage = "*Invalid discount code";
      emit(CartError());
    }, (ParentModel r) async {
      await getCartProducts(shopUUID);
      promoCodeMessage = "";
      if (!forTest) {
        MyToast("Promo Code Removed");
      }
      emit(ConvertBetweenRemoveAndCheck());
    });
  }

  Future<void> addPromotion(
      {bool forTest = false, required String shopUUID}) async {
    try {
      emit(CartPromotionsLoading());
      (await remoteCartRepo!
              .checkPromotions(promoCode: promotionTextFieldController.text))
          .fold((Failure l) {
        promoCodeMessage = "*Invalid discount code";
        emit(CartError());
      }, (ParentModel r) async {
        await getCartProducts(shopUUID);
        promoCodeMessage = "";
        isPromotionAlreadyExist = true;
        if (!forTest) {
          MyToast("Discount Done");
        }
        emit(ConvertBetweenRemoveAndCheck());
      });
    } catch (e) {
      if (!forTest) {
        MyToast("Invalid promo code");
      }
    }
  }

  // void deleteAddress(int index) {
  //   addresses.removeAt(index);
  //   emit(CartDeleteAddress());
  // }

  Future<void> removeFromCart(String itemKey) async {
    try {
      final int index = cartModel!.cart!.items!.indexWhere(
        (CartItemModel element) => element.uuid == itemKey,
      );
      cartModel!.cart!.items!.removeAt(index);
      emit(CartLoading());
      (await remoteCartRepo!
              .deleteProductFromCart(itemKey, cartModel!.cart!.uuid!))
          .fold((Failure l) {
        emit(CartError());
      }, (ParentModel r) {
        cartModel = r as CartModel;
        emit(RemoveFromCart());
      });
    } catch (e) {
      emit(CartError());
    }
  }

  Future<void> increaseItemCount(
      {required String itemUUID, required int quantity}) async {
    try {
      cartModel!.cart!.items!
          .firstWhere(
            (CartItemModel element) => element.uuid == itemUUID,
          )
          .quantity = quantity.toString();

      emit(UpdateCartInLoading());
      (await remoteCartRepo!
              .updateProductToCart(itemUUID, quantity, cartModel!.cart!.uuid!))
          .fold((Failure l) {
        emit(CartError());
      }, (ParentModel r) {
        cartModel = r as CartModel;
        emit(CartUpdated());
      });
    } catch (e) {
      emit(CartError());
    }
  }

  Future<void> decreaseItemCount(
      {required String itemUUID, required int quantity}) async {
    try {
      cartModel!.cart!.items!
          .firstWhere(
            (CartItemModel element) => element.uuid == itemUUID,
          )
          .quantity = quantity.toString();

      if (quantity > 0) {
        emit(UpdateCartInLoading());
        (await remoteCartRepo!.updateProductToCart(
                itemUUID, quantity, cartModel!.cart!.uuid!))
            .fold((Failure l) {
          emit(CartError());
        }, (ParentModel r) {
          cartModel = r as CartModel;
          emit(CartUpdated());
        });
      } else {
        removeFromCart(itemUUID);
      }
    } catch (e) {
      emit(CartError());
    }
  }

  void setShowSummaryValue() {
    showSummary = !showSummary;
    emit(CartCubitShowSummary());
  }

  bool isInCart(String productUuid) {
    return cartModel!.cart!.items!
        .where((CartItemModel element) => element.productUuid == productUuid)
        .isNotEmpty;
  }
}
