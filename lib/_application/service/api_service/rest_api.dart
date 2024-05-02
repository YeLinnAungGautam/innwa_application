import "package:innwa_mobile_dev/_application/constant/api_key.dart";
import "package:innwa_mobile_dev/_application/service/api_service/api_service.dart";

class RestAPI {
  Future<void> init() async {
    api = ApiService(
      baseUrl: ApiKey.base,
      onBeforeValidate: () async {
        return true;
      },
      onAfterValidate: (data) async {
        final value = data as Map<String, dynamic>;
        if (value["status"] == "success" || value["status"] == "error") {
          return true;
        } else {
          return false;
        }
      },
      onError: () async {},
    );
    return;
  }

  late ApiService api;
}
