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

  static ApiRequest updateProfileImage() {
    ApiRequest request = ApiRequest();
    request.endpoint = ApiUrls.updateProfileImageUrl;
    request.method = ApiType.post;
    return request;
  }
}
