class ApiResponse<T> {
  final String status;
  final String responseMessage;
  final T? data;
  final ApiError? error;

  ApiResponse({
    required this.status,
    required this.responseMessage,
    this.data,
    this.error,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? parseData,
  ) {
    final String responseStatus = json['ResponseStatus'] ?? 'Fail';
    final bool isSuccess = responseStatus == 'Success';
    final String message =
        json['ResponseMessage'] ?? 'An unknown error occurred.';

    T? parsedData;

    // --- Start of Correction ---
    if (isSuccess) {
      final dynamic dataField = json['Data'];

      if (dataField != null) {
        // SCENARIO 1: A parser function IS provided. Use it.
        // This is for when you expect a custom model object (e.g., User, Product).
        if (parseData != null) {
          // Safety check: Don't parse empty maps or lists unless intended.
          if ((dataField is Map && dataField.isNotEmpty) ||
              (dataField is List && dataField.isNotEmpty)) {
            parsedData = parseData(dataField);
          }
        }
        // SCENARIO 2: No parser is provided, but the requested type is Map<String, dynamic>.
        // This is perfect for your login response where you just want the raw Data map.
        else if (T == Map<String, dynamic>) {
          parsedData = dataField as T?;
        }
      }
      // If dataField is null, parsedData remains null, which is safe.
    }
    // --- End of Correction ---

    return ApiResponse<T>(
      status: responseStatus,
      responseMessage: message,
      data: parsedData,
      error: !isSuccess ? ApiError(errorMsg: message) : null,
    );
  }

  bool get isSuccess => status == 'Success';
}

class ApiError {
  final String? errorMsg;

  ApiError({this.errorMsg});

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(errorMsg: json['errorMsg']);
  }
}
