import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/model.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/util.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/validation.dart';

class ApiMethods {
  ApiMethods({
    required this.baseUrl,
    required this.dio,
  });

  String baseUrl;
  Dio dio;

  Future<void> query<T, R>({
    required String method,
    required String path,
    required bool isContent,
    required CallBackFunc<T> onSuccess,
    required BeforeCallBackConfig<bool?> beforeValidate,
    required AfterCallBackConfig<T, bool?> afterValidate,
    required CallBackConfig timeOutError,
    required CallBackConfig error,
    dynamic data,
    CallBackWithReturn? oldBeforeValidate,
    CallBack? oldAfterValidate,
    CallBackNoArgs? oldTimeOutError,
    CallBackNoArgs? oldError,
  }) async {
    bool isGetMethod = false;
    // checking the query method
    if (method.toLowerCase() == "GET".toLowerCase()) {
      isGetMethod = true;
    }
    if (method.toLowerCase() != "GET".toLowerCase() && data == null) {
      printError("You need data to send server 🥹");
      throw "Error Throwing : You need data to send server 🥹";
    }

    if (!await checkBeforeValidate(
      beforeValidate: beforeValidate,
      oldBeforeValidate: oldBeforeValidate,
    )) {
      return;
    }

    // start to call api request
    try {
      debugPrint(
          "-----------data---------------------$data--------------------------------");
      final Response response = await _dioMethod(
        name: method,
        path: path,
        data: data,
      );

      if (isContent) {
        await onSuccess(response.data);
      }

      final responseData = response.data as T;

      if (!await checkAfterValidate<T>(
        data: responseData,
        afterValidate: afterValidate,
        oldAfterValidate: oldAfterValidate,
      )) {
        return;
      }

      await onSuccess(responseData);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        await checkTimeOut(
          timeOutError: timeOutError,
          oldTimeOutError: oldTimeOutError,
        );
      } else {
        printError("Dio Excepition error -->");
        await checkError(error: error, oldError: oldError);
      }
    }
  }

  void setConfig(
    String? basePath,
    String? contentType,
  ) {
    if (contentType != null) {
      dio.options.headers["Content-Type"] = contentType;
    } else {
      dio.options.headers["Content-Type"] = "application/json";
    }

    if (basePath == null) {
      dio.options.baseUrl = baseUrl;
    } else {
      dio.options.baseUrl = basePath;
    }
  }

  void checkToken(
    String? alreadyToken,
    String? newToken, {
    required bool isAlreadyToken,
  }) {
    if (isAlreadyToken) {
      if (alreadyToken == null) {
        printError(
          "You have no already token. Set up your token before calling this API ! 😅",
        );
        throw "Error Throwing : you have no token";
      } else {
        dio.options.headers["Authorization"] = "Bearer $alreadyToken";
      }
    } else {
      if (newToken == null) {
        printError(
          "You are calling the un-authenticated public API. You have no token.",
        );
      } else {
        dio.options.headers["Authorization"] = "Bearer $newToken";
      }
    }
  }

  Future<Response> _dioMethod({
    required String name,
    required String path,
    dynamic data,
  }) async {
    final options = Options().copyWith();
    switch (name) {
      case "GET":
        return await dio.get(
          path,
          data: data,
          options: options,
        );
      case "POST":
        return await dio.post(
          path,
          data: data,
          options: options,
        );
      case "PUT":
        return await dio.put(
          path,
          data: data,
          options: options,
        );
      case "DELETE":
        return await dio.delete(
          path,
          options: options,
        );
      default:
        throw "Error Throwing : API method does not correct. Use all capital letter";
    }
  }
}
