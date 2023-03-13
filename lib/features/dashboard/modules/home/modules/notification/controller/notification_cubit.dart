import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/notification/provider/model/notification_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/notification/provider/repository/notification_repository.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial()) {
    init();
  }

  List<NotificationModel> notificationModels = <NotificationModel>[];
  List<NotificationModel> readNotificationList = <NotificationModel>[];

  // Future<void> init() async {
  //   emit(NotificationLoading());
  //   notificationModels =
  //       await NotificationRepository.instance.getNotificationsLocally();
  //   emit(NotificationFinishLoading());
  // }
  Future<void> init() async {
    emit(NotificationLoading());
    (await NotificationRepository.instance.getNotifications()).fold(
        (Failure l) {
      emit(NotificationFailure());
    }, (List<NotificationModel> r) {
      notificationModels = r;
      readNotificationList = notificationModels
          .where((NotificationModel element) => element.readAt == null)
          .toList();
      emit(NotificationFinishLoading());
    });
  }

  Future<void> readNotification({required int index}) async {
    emit(NotificationReadLoading());
    final NotificationModel notificationModel = notificationModels[index];
    (await NotificationRepository.instance.readNotifications(
            uuid: notificationModel.uuid!, source: notificationModel.service!))
        .fold((Failure l) {
      emit(NotificationFailure());
    }, (List<NotificationModel> r) {
      final int newIndex = readNotificationList.indexWhere(
          (NotificationModel element) =>
              element.uuid == notificationModels[index].uuid);

      readNotificationList.removeAt(newIndex);

      notificationModels[index].readAt = DateTime.now();
      emit(NotificationFinishLoading());
    });
  }


  Future<void> deleteNotification({required int index}) async {
    emit(NotificationReadLoading());
    final NotificationModel notificationModel = notificationModels[index];
    (await NotificationRepository.instance.deleteNotifications(
            uuid: notificationModel.uuid!, source: notificationModel.service!))
        .fold((Failure l) {
      emit(NotificationFailure());
    }, (List<NotificationModel> r) {
      final int newIndex = notificationModels.indexWhere(
          (NotificationModel element) =>
              element.uuid == notificationModels[index].uuid);

      notificationModels.removeAt(newIndex);

      // notificationModels[index].readAt = DateTime.now();
       emit(NotificationDelete());
    });
  }

// void deleteNotification(int index) {
//   notificationModels.removeAt(index);
//   emit(NotificationDelete());
// }

}
