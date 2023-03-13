import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/controller/cart_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/provider/models/cart_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/provider/repo/remote_cart_repo.dart';

import 'cart_controller_test.mocks.dart';

@GenerateMocks(<Type>[
  RemoteCartRepo
])
void main() {
  late MockRemoteCartRepo repository;
  setUpAll(() {
    repository = MockRemoteCartRepo();
  });

  group('test group CartCubit', () {
    ///--------resetCartAndPromoCode method testing------///
    blocTest<CartCubit, CartState>(
      'verify that resetCartAndPromoCode method return success',
      build: () => CartCubit(repository),
      act: (CartCubit bloc) => bloc.resetCartAndPromoCode(),
      expect: () => <TypeMatcher<CartState>>[],
    );

    blocTest<CartCubit, CartState>(
      'verify that resetPromoCode method return success',
      build: () => CartCubit(repository),
      act: (CartCubit bloc) => bloc.resetPromoCode(),
      expect: () => <TypeMatcher<CartState>>[],
    );

    blocTest<CartCubit, CartState>(
      'verify that setIsPromotion method return success',
      build: () => CartCubit(repository),
      act: (CartCubit bloc) => bloc.setIsPromotion(""),
      expect: () => <TypeMatcher<CartState>>[],
    );

    blocTest<CartCubit, CartState>(
      'verify that setCurrentProduct method return success',
      build: () => CartCubit(repository),
      act: (CartCubit bloc) => bloc.setCurrentProduct("test1"),
      expect: () => <TypeMatcher<CartState>>[
        isA<CartInitial>()
      ],
    );

    blocTest<CartCubit, CartState>(
      'verify that conditionToRebuild method return success',
      build: () => CartCubit(repository),
      act: (CartCubit bloc) {
        bloc.currentProduct="test1";
        return bloc.conditionToRebuild("test1");
      },
      expect: () => <TypeMatcher<CartState>>[],
    );

    blocTest<CartCubit, CartState>(
      'verify that setShowSummaryValue method return success',
      build: () => CartCubit(repository),
      act: (CartCubit bloc) {
        return bloc.setShowSummaryValue();
      },
      expect: () => <TypeMatcher<CartState>>[
        isA<CartCubitShowSummary>()
      ],
    );

    blocTest<CartCubit, CartState>(
      'verify that isInCart method return success',
      build: () => CartCubit(repository),
      act: (CartCubit bloc) {
        bloc.cartModel=CartModel(cart: Cart(uuid: "21312sdfds",items: <CartItemModel>[CartItemModel(uuid: "asdas334")]));
        return bloc.isInCart("test1");
      },
      expect: () => <TypeMatcher<CartState>>[],
    );

    blocTest<CartCubit, CartState>(
      'verify that isInCart method return fail',
      build: () => CartCubit(repository),
      act: (CartCubit bloc) {
        bloc.cartModel=CartModel(cart: Cart(uuid: "21312sdfds",items: <CartItemModel>[CartItemModel(uuid: "asdas334")]));
        return bloc.isInCart("test1");
      },
      expect: () => <TypeMatcher<CartState>>[],
    );
    blocTest<CartCubit, CartState>(
      'onSuccess Test addToCart',
      build: () {
        when(repository.addProductToCart("testUUID","testCardUUID"))
            .thenAnswer((Invocation realInvocation) async =>
            Right<Failure, ParentModel>(CartModel()));
        return CartCubit(repository);
      },
      act: (CartCubit bloc) {
        bloc.addToCart("testUUID");
      },
      expect: () => <TypeMatcher<CartState>>[
        isA<ItemAdditionInLoading>(),
        isA<CartLoaded>(),
      ],
    );
  });

  group('addToCart method testing', () {
    ///--------addToCart method testing------///
    blocTest<CartCubit, CartState>(
      'onSuccess Test addToCart',
      build: () {
        when(repository.addProductToCart("testUUID","testCardUUID"))
            .thenAnswer((Invocation realInvocation) async =>
            Right<Failure, ParentModel>(CartModel()));
        return CartCubit(repository);
      },
      act: (CartCubit bloc) {
        bloc.addToCart("testUUID");
      },
      expect: () => <TypeMatcher<CartState>>[
        isA<ItemAdditionInLoading>(),
        isA<CartLoaded>(),
      ],
    );

    blocTest<CartCubit, CartState>(
      'verify that isInCart method return fail',
      build: () => CartCubit(repository),
      act: (CartCubit bloc) {
        bloc.cartModel=CartModel(cart: Cart(uuid: "21312sdfds",items: <CartItemModel>[CartItemModel(uuid: "asdas334")]));
        return bloc.isInCart("test1");
      },
      expect: () => <TypeMatcher<CartState>>[],
    );
    blocTest<CartCubit, CartState>(
      'onSuccess Test addToCart',
      build: () {
        when(repository.addProductToCart("testUUID","testCardUUID"))
            .thenAnswer((Invocation realInvocation) async =>
            Right<Failure, ParentModel>(CartModel()));
        return CartCubit(repository);
      },
      act: (CartCubit bloc) {
        bloc.addToCart("testUUID");
      },
      expect: () => <TypeMatcher<CartState>>[
        isA<ItemAdditionInLoading>(),
        isA<CartLoaded>(),
      ],
    );

    blocTest<CartCubit, CartState>(
      'onFail Test addToCart',
      build: () {
        when(repository.addProductToCart("testUUID","testCardUUID"))
            .thenAnswer((Invocation realInvocation) async => Left<Failure, ParentModel>(ApiFailure()));
        return CartCubit(repository);
      },
      act: (CartCubit bloc) {
        bloc.addToCart("testUUID");
      },
      expect: () => <TypeMatcher<CartState>>[
        isA<ItemAdditionInLoading>(),
        isA<CartError>(),
      ],
    );
  });

  group('getCartProducts method testing', () {
    ///--------addToCart method testing------///

    blocTest<CartCubit, CartState>(
      'onFail Test getCartProducts',
      build: () {
        when(repository.getCartProducts("testShopUUID"))
            .thenAnswer((Invocation realInvocation) async => Left<Failure, ParentModel>(ApiFailure()));
        return CartCubit(repository);
      },
      act: (CartCubit bloc) {
        bloc.getCartProducts("");
      },
      expect: () => <TypeMatcher<CartState>>[
        isA<CartLoading>(),
        isA<CartError>(),
      ],
    );

    blocTest<CartCubit, CartState>(
      'onSuccess Test getCartProducts',
      build: () {
        when(repository.getCartProducts("testShopUUID"))
            .thenAnswer((Invocation realInvocation) async =>
            Right<Failure, ParentModel>(CartModel()));
        return CartCubit(repository);
      },
      act: (CartCubit bloc) {
        bloc.getCartProducts("");
      },
      expect: () => <TypeMatcher<CartState>>[
        isA<CartLoading>(),
        isA<CartLoaded>(),
      ],
    );

  });

  group('removePromotion method testing', () {
    ///--------removePromotion method testing------///
    blocTest<CartCubit, CartState>(
      'onSuccess Test removePromotion',
      build: () {
        when(repository.removePromotions(promoCode: "dd32344"))
            .thenAnswer((Invocation realInvocation) async =>
            Right<Failure, ParentModel>(CartModel()));
        return CartCubit(repository);
      },
      act: (CartCubit bloc) {
        bloc.promotionTextFieldController.text="dd32344";
        bloc.removePromotion(forTest: true,shopUUID: "");
      },
      expect: () => <TypeMatcher<CartState>>[
        isA<CartPromotionsLoading>(),
        isA<CartLoading>(),
        isA<CartLoaded>(),
        isA<ConvertBetweenRemoveAndCheck>(),
      ],
    );

    blocTest<CartCubit, CartState>(
      'onFail Test removePromotion',
      build: () {
        when(repository.removePromotions(promoCode: "dd32344"))
            .thenAnswer((Invocation realInvocation) async => Left<Failure, ParentModel>(ApiFailure()));
        return CartCubit(repository);
      },
      act: (CartCubit bloc) {
        bloc.promotionTextFieldController.text="dd32344";
        bloc.removePromotion(forTest: true,shopUUID: "");
      },
      expect: () => <TypeMatcher<CartState>>[
        isA<CartPromotionsLoading>(),
        isA<CartError>(),
      ],
    );
  });

  group('addPromotion method testing', () {
    ///--------addPromotion method testing------///
    blocTest<CartCubit, CartState>(
      'onSuccess Test addPromotion',
      build: () {
        when(repository.checkPromotions(promoCode: "dd32344"))
            .thenAnswer((Invocation realInvocation) async =>
            Right<Failure, ParentModel>(CartModel()));
        return CartCubit(repository);
      },
      act: (CartCubit bloc) {
        bloc.promotionTextFieldController.text="dd32344";
        bloc.addPromotion(forTest: true,shopUUID: "");
      },
      expect: () => <TypeMatcher<CartState>>[
        isA<CartPromotionsLoading>(),
        isA<CartLoading>(),
        isA<CartLoaded>(),
        isA<ConvertBetweenRemoveAndCheck>(),
      ],
    );

    blocTest<CartCubit, CartState>(
      'onFail Test addPromotion',
      build: () {
        when(repository.getCartProducts("testShopUUID"))
            .thenAnswer((Invocation realInvocation) async => Left<Failure, ParentModel>(ApiFailure()));
        return CartCubit(repository);
      },
      act: (CartCubit bloc) {
        bloc.promotionTextFieldController.text="dd32344";
        bloc.removePromotion(forTest: true,shopUUID: "");
      },
      expect: () => <TypeMatcher<CartState>>[
        isA<CartPromotionsLoading>(),
        isA<CartError>(),
      ],
    );
  });

  group('removeFromCart method testing', () {

    ///--------removeFromCart method testing------///
    blocTest<CartCubit, CartState>(
      'onSuccess Test removeFromCart',
      build: () {
        when(repository.deleteProductFromCart("dd32344","testCartUUID"))
            .thenAnswer((Invocation realInvocation) async =>
            Right<Failure, ParentModel>(CartModel()));
        return CartCubit(repository);
      },
      act: (CartCubit bloc) {
        bloc.cartModel=CartModel(cart: Cart(uuid: "21312sdfds",items: <CartItemModel>[CartItemModel(uuid: "dd32344")]));
        bloc.removeFromCart("dd32344");
      },
      expect: () => <TypeMatcher<CartState>>[
        isA<CartLoading>(),
        isA<RemoveFromCart>(),
      ],
    );

    blocTest<CartCubit, CartState>(
      'onFail Test removeFromCart',
      build: () {
        when(repository.deleteProductFromCart("dd32344","testCartUUID"))
            .thenAnswer((Invocation realInvocation) async => Left<Failure, ParentModel>(ApiFailure()));
        return CartCubit(repository);
      },
      act: (CartCubit bloc) {
        bloc.cartModel=CartModel(cart: Cart(uuid: "21312sdfds",items: <CartItemModel>[CartItemModel(uuid: "dd32344")]));
        bloc.removeFromCart("dd32344");
      },
      expect: () => <TypeMatcher<CartState>>[
        isA<CartLoading>(),
        isA<CartError>(),
      ],
    );
  });

  group('increaseItemCount method testing', () {

    ///--------increaseItemCount method testing------///
    blocTest<CartCubit, CartState>(
      'onSuccess Test increaseItemCount',
      build: () {
        when(repository.updateProductToCart("dd32344",1,"testCartUUID"))
            .thenAnswer((Invocation realInvocation) async =>
            Right<Failure, ParentModel>(CartModel()));
        return CartCubit(repository);
      },
      act: (CartCubit bloc) {
        bloc.cartModel=CartModel(cart: Cart(uuid: "21312sdfds",items: <CartItemModel>[CartItemModel(uuid: "dd32344")]));
        bloc.increaseItemCount(quantity: 1,itemUUID: "dd32344");
      },
      expect: () => <TypeMatcher<CartState>>[
        isA<UpdateCartInLoading>(),
        isA<CartUpdated>(),
      ],
    );

    blocTest<CartCubit, CartState>(
      'onFail Test increaseItemCount',
      build: () {
        when(repository.updateProductToCart("dd32344",2,"testCartUUID"))
            .thenAnswer((Invocation realInvocation) async => Left<Failure, ParentModel>(ApiFailure()));
        return CartCubit(repository);
      },
      act: (CartCubit bloc) {
        bloc.cartModel=CartModel(cart: Cart(uuid: "21312sdfds",items: <CartItemModel>[CartItemModel(uuid: "dd32344")]));
        bloc.increaseItemCount(itemUUID: "dd32344",quantity: 2);
      },
      expect: () => <TypeMatcher<CartState>>[
        isA<UpdateCartInLoading>(),
        isA<CartError>(),
      ],
    );
  });

  group('decreaseItemCount method testing', () {

    ///--------decreaseItemCount method testing------///
    blocTest<CartCubit, CartState>(
      'onSuccess Test decreaseItemCount',
      build: () {
        when(repository.updateProductToCart("dd32344",1,"testCartUUID"))
            .thenAnswer((Invocation realInvocation) async =>
            Right<Failure, ParentModel>(CartModel()));
        return CartCubit(repository);
      },
      act: (CartCubit bloc) {
        bloc.cartModel=CartModel(cart: Cart(uuid: "21312sdfds",items: <CartItemModel>[CartItemModel(uuid: "dd32344")]));
        bloc.decreaseItemCount(quantity: 1,itemUUID: "dd32344");
      },
      expect: () => <TypeMatcher<CartState>>[
        isA<UpdateCartInLoading>(),
        isA<CartUpdated>(),
      ],
    );

    blocTest<CartCubit, CartState>(
      'onFail Test decreaseItemCount',
      build: () {
        when(repository.updateProductToCart("dd32344",2,"testCartUUID"))
            .thenAnswer((Invocation realInvocation) async => Left<Failure, ParentModel>(ApiFailure()));
        return CartCubit(repository);
      },
      act: (CartCubit bloc) {
        bloc.cartModel=CartModel(cart: Cart(uuid: "21312sdfds",items: <CartItemModel>[CartItemModel(uuid: "dd32344")]));
        bloc.decreaseItemCount(itemUUID: "dd32344",quantity: 2);
      },
      expect: () => <TypeMatcher<CartState>>[
        isA<UpdateCartInLoading>(),
        isA<CartError>(),
      ],
    );
  });
}
