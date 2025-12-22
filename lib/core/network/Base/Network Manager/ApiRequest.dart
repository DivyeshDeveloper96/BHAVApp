import 'ApiManager.dart';

class ApiRequest {
  late final String endpoint;
  late final ApiType method;
  Map<String, dynamic>? query;
  Map<String, dynamic>? body;
  Map<String, String>? headers;
  bool tokenRequired = true;
}
