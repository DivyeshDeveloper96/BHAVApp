// lib/core/controllers/base_api_controller.dart
import 'package:get/get.dart';
import '../network/api_provider.dart';

abstract class BaseApiController<T> extends GetxController {
  var isLoading = false.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;
  var data = <T>[].obs;

  /// Override this to set the API endpoint
  String get endpoint;

  /// Override this to parse the raw response into a list of T
  List<T> parseResponse(dynamic response);

  void fetchData() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';

      final response = await ApiProvider.get(endpoint);
      if (response != null) {
        data.value = parseResponse(response);
      } else {
        hasError.value = true;
        errorMessage.value = 'No data returned';
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Something went wrong: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  void retry() {
    fetchData();
  }
}
