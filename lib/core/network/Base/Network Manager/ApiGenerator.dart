import 'package:bhavapp/core/network/Base/Network%20Manager/ApiRequest.dart';
import 'ApiManager.dart';
import 'ApiUrls.dart';

class ApiGenerator {
  static ApiRequest getProfile() {
    ApiRequest request = ApiRequest();
    request.endpoint = "${ApiUrls.getProfileUrl}";
    request.method = ApiType.get;
    return request;
  }

  static ApiRequest loginSentOtp(Map<String, dynamic> body) {
    ApiRequest request = ApiRequest();
    request.endpoint = ApiUrls.loginSentOTP;
    request.body = body;
    request.method = ApiType.post;
    return request;
  }

  static ApiRequest verifyOtp(Map<String, dynamic> body) {
    ApiRequest request = ApiRequest();
    request.endpoint = ApiUrls.verifyOtp;
    request.body = body;
    request.method = ApiType.post;
    return request;
  }

  static ApiRequest getYatraList() {
    ApiRequest request = ApiRequest();
    request.endpoint = ApiUrls.getYatraListUrl;
    request.method = ApiType.get;
    return request;
  }

  static ApiRequest getYatraDeatils(String yatraId) {
    ApiRequest request = ApiRequest();
    request.endpoint =
        "${ApiUrls.getYatraDetailsUrl}$yatraId?includeClosed=true";
    request.method = ApiType.get;
    return request;
  }
}
