import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/notification/provider/API/notification_api.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/notification/provider/model/notification_model.dart';

class NotificationRepository {
  late final NotificationAPI _api;

  NotificationRepository._singleTone() {
    _api = NotificationAPI.instance;
  }

  static final NotificationRepository _instance =
      NotificationRepository._singleTone();

  static NotificationRepository get instance => _instance;

  Future<List<NotificationModel>> getNotificationsLocally() async {
    final String response =
        await rootBundle.loadString('assets/jsons/notification.json');
    final List<Map<String, dynamic>> data =
        (await json.decode(response) as List<dynamic>)
            .cast<Map<String, dynamic>>();
    return data
        .map((dynamic e) =>
            NotificationModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Either<Failure, List<NotificationModel>>> getNotifications() async {
    try {
      /// --------------------------- Calling API Function ------------------------ ///
      final Either<Failure, Response<dynamic>> res =
          await _api.getNotificationModel();

      return res.fold((Failure l) => Left<Failure, List<NotificationModel>>(l),
          (Response<dynamic> response) {
        if (response.statusCode != 200 ||
            !((response.data as Map<String, dynamic>?)!['success'] as bool)) {
          /// Failure Response
          return Left<Failure, List<NotificationModel>>(ApiFailure(
              code: response.statusCode,
              resourceName: 'Registration_repository_line_35',
              errors: ((response.data as Map<String, dynamic>?)!['errors']
                      as Map<String, dynamic>?) ??
                  <String, String>{}));
        } else {
          /// Success
          return Right<Failure, List<NotificationModel>>((((response.data
                      as Map<String, dynamic>?)!['data']
                  as Map<String, dynamic>)['notifications'] as List<dynamic>)
              .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
              .toList());
        }
      });
    } on Exception catch (e) {
      /// Repository Crashed
      return Left<Failure, List<NotificationModel>>(ApiFailure(
        errors: <String, String>{'': e.toString()},
        code: 404,
        resourceName: 'ForgetPassword_repository_line_50',
      ));
    }
  }
  
  Future<Either<Failure, List<NotificationModel>>> readNotifications({required String uuid,required String source}) async {
    try {
      /// --------------------------- Calling API Function ------------------------ ///
      final Either<Failure, Response<dynamic>> res =
          await _api.readNotification(uuid: uuid, source: source);

      return res.fold((Failure l) => Left<Failure, List<NotificationModel>>(l),
          (Response<dynamic> response) {
        if (response.statusCode != 200 ||
            !((response.data as Map<String, dynamic>?)!['success'] as bool)) {
          /// Failure Response
          return Left<Failure, List<NotificationModel>>(ApiFailure(
              code: response.statusCode,
              resourceName: 'Registration_repository_line_35',
              errors: ((response.data as Map<String, dynamic>?)!['errors']
                      as Map<String, dynamic>?) ??
                  <String, String>{}));
        } else {
          /// Success
          return const Right<Failure, List<NotificationModel>>(<NotificationModel>[]);
        }
      });
    } on Exception catch (e) {
      /// Repository Crashed
      return Left<Failure, List<NotificationModel>>(ApiFailure(
        errors: <String, String>{'': e.toString()},
        code: 404,
        resourceName: 'ForgetPassword_repository_line_50',
      ));
    }
  }
  Future<Either<Failure, List<NotificationModel>>> deleteNotifications({required String uuid,
    required String source}) async {
    try {
      /// --------------------------- Calling API Function ------------------------ ///
      final Either<Failure, Response<dynamic>> res =
          await _api.deleteNotification(uuid: uuid, source: source);

      return res.fold((Failure l) => Left<Failure, List<NotificationModel>>(l),
          (Response<dynamic> response) {
        if (response.statusCode != 200 ||
            !((response.data as Map<String, dynamic>?)!['success'] as bool)) {
          /// Failure Response
          return Left<Failure, List<NotificationModel>>(ApiFailure(
              code: response.statusCode,
              resourceName: 'Notification_repository_line_35',
              errors: ((response.data as Map<String, dynamic>?)!['errors']
                      as Map<String, dynamic>?) ??
                  <String, String>{}));
        } else {
          /// Success
          return const Right<Failure, List<NotificationModel>>(<NotificationModel>[]);
        }
      });
    } on Exception catch (e) {
      /// Repository Crashed
      return Left<Failure, List<NotificationModel>>(ApiFailure(
        errors: <String, String>{'': e.toString()},
        code: 404,
        resourceName: 'notification_repository_line_50',
      ));
    }
  }
}
