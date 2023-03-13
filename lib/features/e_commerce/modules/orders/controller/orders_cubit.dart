import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/provider/models/cart_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/model/complain_order_inputs.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/model/order_item_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/model/order_list_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/model/order_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/repo/orders_repo.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this._repo) : super(OrdersInitial()) {
    getOrders();
  }
  TextEditingController searchBarController = TextEditingController();
  OrderListModel model = OrderListModel();

  String? _status;

  String? get filterStatus => _status;

  void resetSearchBar(){
    searchBarController.clear();
    query="";
    emit(OrdersCubitResetSearchbar());
  }

  late OrderModel order;

  List<String> complainFiles = <String>["", "", ""];

  String cancelReason = '';
  String complainReason = '';
  String complainReasonType = 'Inappropriate items';

  bool get isOrderProcessing {
    return order.status == "paid" || order.status == "pending" || order.status == "in-progress";
  }

  bool get orderCompleted {
    return order.status == "returned" || order.status == "delivered";
  }

  bool get orderShipped {
    return order.status == "shipped" || order.status == "delivered" || order.status == "returned";
  }

  set filterStatus(String? status) {
    _status = status;
    emit(OrderFilterStatusChanged(status));
  }

  bool showOrdersFilters = false;
  List<OrderModel> get orders {
    List<OrderModel> ordersList = <OrderModel>[];
    if (query.isEmpty) {
      ordersList = model.orders;
    } else {
      ordersList = model.orders.where(
        (OrderModel element) {
          return <String>[element.orderNumber, ...element.products.map((OrderItemModel e) => e.title)]
              .any((String element) => element.startsWith(query));
        },
      ).toList();
    }
    if (_status != null) {
      ordersList = ordersList.where((OrderModel element) => element.status == _status).toList();
    }
    return ordersList;
  }

  String query = '';

  final OrdersRepo _repo;
  Future<void> getOrders() async {
    try {
      emit(OrdersLoading());
      final Either<Failure, ParentModel> result = await _repo.get();
      result.fold((Failure failure) {
        emit(OrdersFailure(failure));
      }, (ParentModel r) {
        model = r as OrderListModel;
        if (model.orders.isNotEmpty) {
          showOrdersFilters = true;
        }
        emit(OrdersLoaded());
      });
    } catch (_) {
      emit(OrdersFailure(ApiFailure()));
    }
  }

  Future<void> track(OrderModel order) async {
    this.order = order;
    emit(SingleOrderLoading());
    final Either<Failure, OrderModel> result = await _repo.trackOrder(order.uuid);
    result.fold((Failure l) {
      emit(SingleOrderFailure(l));
    }, (OrderModel r) {
      this.order = r;
      emit(OrderTracked());
    });
  }

  Future<CartModel?> buyAgain(String uuid) async {
    emit(OrderBoughtAgainLoading());
    // call buy again api and return created order if success
    final Either<Failure, ParentModel> result = await _repo.buyAgain(uuid);
    return result.fold((Failure l) {
      emit(OrderBoughtAgainError(l));
      return null;
    }, (ParentModel r) {
      emit(OrderBoughtAgainLoaded());
      return r as CartModel;
    });
  }

  Future<void> cancelOrder() async {
    emit(SingleOrderLoading());

    final Option<Failure> result = await _repo.cancel(
      description: cancelReason,
      orderUUID: order.uuid,
    );
    result.fold(() {
      order.status = "canceled";
      final int index = model.orders.indexWhere((OrderModel element) => element.uuid == order.uuid);
      model.orders[index].status = "canceled";
      emit(OrderCanceled());
    }, (Failure a) {
      emit(SingleOrderFailure(a));
    });
  }

  Future<void> complain() async {
    emit(SingleOrderLoading());
    final ComplainOrderInput inputs = ComplainOrderInput(
      orderUUID: order.uuid,
      reasonType: complainReasonType,
      description: complainReason,
      images: complainFiles.where((String element) => element.isNotEmpty).toList(),
    );
    final Option<Failure> result = await _repo.complain(inputs);
    result.fold(() {
      getOrders();
      emit(OrderComplained());
    }, (Failure a) {
      emit(SingleOrderFailure(a));
    });
  }

  Future<void> addImage(int index) async {
    final XFile? result = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (result != null) {
      complainFiles[index] = result.path;
      emit(OrderComplainImagePicked(result.path, index));
    }
  }

  void removeImages(int index) {
    complainFiles[index] = '';
    emit(OrderComplainImagePicked('', index));
  }

  void search(String query) {
    this.query = query;
    emit(OrdersSearched(query));
  }

  void onCancelReasonChanged(String value) {
    cancelReason = value;
    emit(OrdersLoaded());
  }
}
