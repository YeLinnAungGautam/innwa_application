import "package:dio/dio.dart";
import "package:innwa_mobile_dev/_application/service/api_service/dio_methods.dart";
import "package:innwa_mobile_dev/_application/service/api_service/util.dart";


class RestApiData {
  RestApiData._();

  static late Dio dio;
  static late ApiMethods methods;

  static String? token;
  static bool? isOnline;
  static late bool isUseHttp2;
}

class BeforeCallBackConfig<T> extends CallBackModel {
  BeforeCallBackConfig({
    super.allowBoth,
    super.isAllowDefault,
    this.onCallBack,
  });

  CallBack<T>? onCallBack;
}

class AfterCallBackConfig<T, R> extends CallBackModel {
  AfterCallBackConfig({
    super.allowBoth,
    super.isAllowDefault,
    this.onCallBack,
  });

  AfterCallBack<T, R>? onCallBack;
}

class CallBackConfig extends CallBackModel {
  CallBackConfig({
    super.allowBoth,
    super.isAllowDefault,
    this.onCallBack,
  });

  CallBackNoArgs? onCallBack;
}

class CallBackModel {
  CallBackModel({
    this.allowBoth = false,
    this.isAllowDefault = true,
  });

  final bool isAllowDefault;
  final bool allowBoth;
}
