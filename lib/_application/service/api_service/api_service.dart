import "dart:async";

import "package:dio/dio.dart";
import "package:dio_http2_adapter/dio_http2_adapter.dart";
import "package:flutter/foundation.dart";
import "package:innwa_mobile_dev/_application/service/api_service/dio_methods.dart";
import "package:innwa_mobile_dev/_application/service/api_service/model.dart";
import "package:innwa_mobile_dev/_application/service/api_service/util.dart";
import "package:pretty_dio_logger/pretty_dio_logger.dart";

class ApiService {
  ApiService({
    required String baseUrl,
    int? connectTimeout,
    Future<bool> Function()? onBeforeValidate,
    CallBack? onAfterValidate,
    Future<void> Function()? onTimeOutError,
    Future<void> Function()? onError,
    bool useHttp2 = false,
  }) {
    RestApiData.isUseHttp2 = useHttp2;

    _init(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
    );
    _onBeforeValidate = onBeforeValidate;
    _onAfterValidate = onAfterValidate;
    _onTimeOutError = onTimeOutError;

    _onError = onError;
  }

  String? get myToken => RestApiData.token;
  set myToken(String? value) {
    RestApiData.token = value;
    if (value != null) {
      RestApiData.dio.options.headers["Authorization"] = "Bearer $myToken";
    }
  }

  CallBackWithReturn? _onBeforeValidate;

  CallBack? _onAfterValidate;

  CallBackNoArgs? _onTimeOutError;

  CallBackNoArgs? _onError;

  void _init({
    required String baseUrl,
    int? connectTimeout,
  }) {
    final connectionTimeout = connectTimeout == null
        ? const Duration(seconds: 20)
        : Duration(seconds: connectTimeout);
    RestApiData.dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: connectionTimeout,
      ),
    )..options.headers["Content-Type"] = "application/json";
    if (RestApiData.isUseHttp2) {
      RestApiData.dio.httpClientAdapter = Http2Adapter(
        ConnectionManager(
          idleTimeout: connectionTimeout,
          onClientCreate: (_, config) => config.onBadCertificate = (_) => true,
        ),
      );
    }

    if (!kReleaseMode) {
      RestApiData.dio.interceptors.add(
        PrettyDioLogger(
          requestBody: true,
        ),
      );
    }
    RestApiData.methods = ApiMethods(baseUrl: baseUrl, dio: RestApiData.dio);
  }

  Future<void> query<T>({
    required String method,
    required String path,
    required CallBackFunc<T> onSuccess,
    String? basePath,
    Map<String, dynamic>? data,
    String? contentType,
    String? token,
    bool isContent = false,
    bool isAlreadyToken = true,
    BeforeCallBackConfig<bool?>? beforeValidate,
    AfterCallBackConfig<T, bool?>? afterValidate,
    CallBackConfig? timeOutError,
    CallBackConfig? error,
  }) async {
    RestApiData.methods.setConfig(basePath, contentType);
    _checkToken(token, isAlreadyToken);

    await RestApiData.methods.query<T, bool?>(
      method: method,
      path: path,
      data: data,
      isContent: isContent,
      onSuccess: onSuccess,
      beforeValidate: beforeValidate ?? BeforeCallBackConfig(),
      afterValidate: afterValidate ?? AfterCallBackConfig(),
      timeOutError: timeOutError ?? CallBackConfig(),
      error: error ?? CallBackConfig(),
      oldBeforeValidate: _onBeforeValidate,
      oldAfterValidate: _onAfterValidate,
      oldTimeOutError: _onTimeOutError,
      oldError: _onError,
    );
  }

  Future<void> postWithForm<T>({
    required String method,
    required String path,
    required Map<String, dynamic> data,
    required CallBackFunc<T> onSuccess,
    String? basePath,
    List<String>? filePaths,
    String? token,
    bool isContent = false,
    bool isAlreadyToken = true,
    BeforeCallBackConfig<bool?>? beforeValidate,
    AfterCallBackConfig<T, bool?>? afterValidate,
    CallBackConfig? timeOutError,
    CallBackConfig? error,
  }) async {
    if (method.toLowerCase() == "GET".toLowerCase()) {
      printError("postWithForm does not allow with GET method ❌");
      return;
    }

    // form data
    final formData = FormData.fromMap(data);
    if (filePaths != null) {
      for (final i in filePaths) {
        final fileName = i.split("/").last;
        try {
          final file = await MultipartFile.fromFile(i, filename: fileName);
          formData.files.add(
            MapEntry("image", file),
          );
        } on Exception catch (_) {
          printError("Error throwing in formData from file of $i");
        }
      }
    }

    RestApiData.methods.setConfig(
      basePath,
      "multipart/form-data ; boundary=${formData.boundary}",
    );
    _checkToken(token, isAlreadyToken);

    await RestApiData.methods.query<T, bool?>(
      method: method,
      path: path,
      data: formData,
      isContent: isContent,
      onSuccess: onSuccess,
      beforeValidate: beforeValidate ?? BeforeCallBackConfig(),
      afterValidate: afterValidate ?? AfterCallBackConfig(),
      timeOutError: timeOutError ?? CallBackConfig(),
      error: error ?? CallBackConfig(),
      oldBeforeValidate: _onBeforeValidate,
      oldAfterValidate: _onAfterValidate,
      oldTimeOutError: _onTimeOutError,
      oldError: _onError,
    );
  }

  void _checkToken(
    String? token,
    bool isAlreadyToken,
  ) {
    RestApiData.methods.checkToken(
      myToken,
      token,
      isAlreadyToken: isAlreadyToken,
    );
  }
}
