import 'package:get/get.dart';
import '../../core/controllers/base_api_controller.dart';

class HomeController extends BaseApiController<String> {
  @override
  String get endpoint => "/example-endpoint"; // Replace with your real API

  @override
  List<String> parseResponse(response) {
    // Example: response is a list of strings
    // Replace with real parsing logic (e.g., List.from(response.map(...)))
    if (response is List) {
      return response.map((e) => e.toString()).toList();
    }
    return [];
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }
}
