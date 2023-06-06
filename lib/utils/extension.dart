import 'dart:convert';
import 'dart:io';

import 'package:app2/base/base_repository.dart';
import 'package:app2/base/base_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

void showToast(String? msg) {
  if (msg == null) return;
  if (msg.isEmpty) return;

  Fluttertoast.showToast(
      msg: msg ?? '',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0);
}

void closeToast() {
  Fluttertoast.cancel();
}

extension HttpHelper<T> on Future<T> {
  Future<T> request(
      {OnSuccess<T>? onSuccess,
      OnFailed? onFailed,
      bool needShowToast = true}) {
    return then((value) {
      // if (value is LoginResponse) {
      //   value.save();
      // }

      if (value is BaseResponse && value.status != 'ok') {
        if (needShowToast == true) {
          showToast(value.message);
        }
        if (onFailed != null) {
          onFailed(1, value.message, response: value);
        }
      }
      onSuccess?.call(value);
      return value;
    }).catchError((obj) async {
      if (obj is DioError) {
        print('xxxxxx DioError : ${obj.type}');
        print('xxxxxx DioError : ${obj.message}');
        print('xxxxxx DioError : ${obj.error}');
        print('xxxxxx DioError : ${obj.response?.statusCode}');
      }

      //var user = LoginResponse.getCurrentUser();

      if ((getStatusCode(obj) == 401) ||
          getMessage(obj) == 'token_not_provided') {
        //logoutAccount();
      } else if (onFailed != null) {
        onFailed(getStatusCode(obj), getMessage(obj));
      } else {
        if (needShowToast == true) {
          showToast(getMessage(obj));
        }
        throw getMessage(obj);
      }

      if (needShowToast == true) {
        showToast(getMessage(obj));
      }

      throw getMessage(obj);
    });
  }
}

int getStatusCode(Object? obj) {
  switch (obj.runtimeType) {
    case DioError:
      if (obj is DioError) {
        // if (obj.response != null && obj.response.statusCode == 401) {
        //   // ExtendedNavigator.root.replace(Routes.loginScreenPage);
        // } else if (obj.type == DioErrorType.DEFAULT) {
        //   return -1;
        // }

        return (obj.response != null ? obj.response?.statusCode : -1) ?? -1;
      }

      return -1;
    default:
      return -1;
  }
}

String getMessage(Object? obj) {
  switch (obj.runtimeType) {
    case DioError:
      if (obj is DioError) {
        var error = obj.error;
        if (error is SocketException) {
          return error.osError?.message ?? 'Unknown Error';
        }

        if (obj.type == DioErrorType.other) {
          return obj.message ?? '';
        }

        try {
          if (obj.response?.data != null &&
              obj.response?.data['message'] != null &&
              obj.response?.data['message'] is String &&
              obj.response?.data['message']?.toString().isNotEmpty == true) {
            return obj.response?.data['message'];
          }
        } catch (e) {
          print(e);
        }

        try {
          if (obj.response?.data != null) {
            String? jsonDataString = obj.response?.data.toString();
            final jsonData = jsonDecode(jsonDataString ?? "");
            if (jsonData['title'] != null) {
              return jsonData['title'];
            }
          }
        } catch (e) {
          print(e);
        }

        try {
          if (obj.response?.data != null &&
              obj.response?.data['error'] != null &&
              obj.response?.data['error']?.toString().isNotEmpty == true) {
            return obj.response?.data['error'];
          }
        } catch (e) {
          print(e);
        }

        if (obj.type == DioErrorType.other) {
          return obj.message ?? '';
        }

        if (obj.response != null &&
            obj.response?.statusMessage != null &&
            obj.response?.statusMessage?.isNotEmpty == true) {
          return obj.response?.statusMessage ?? '';
        }

        if (obj.type == DioErrorType.connectTimeout) {
          return 'error_ooops'.tr;
        }
      }

      return 'Unknown Error';
    default:
      return '$obj';
  }
}

UniqueKey key = UniqueKey();

extension Inst on GetInterface {
  S createViewModel<S>(S dependency, {String? tag}) {
    Get.delete<S>(tag: tag);

    Get.create(() => dependency, permanent: false, tag: tag);

    return Get.find(tag: tag);
  }
}
