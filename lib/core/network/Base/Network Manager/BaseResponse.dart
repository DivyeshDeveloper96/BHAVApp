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
    final isSuccess = json['Status'] == 'Success';

    return ApiResponse<T>(
      status: json['Status'] ?? 'Fail',
      responseMessage: json['ResponseMessage'] ?? '',
      data: isSuccess && parseData != null ? parseData(json['Data']) : null,
      error: json['Error'] != null ? ApiError.fromJson(json['Error']) : null,
    );
  }

  bool get isSuccess => status == 'Success';
}

class ApiError {
  final String? errorMsg;
  //final Map<String, dynamic>? additionalInfo;

  ApiError({this.errorMsg, /*this.additionalInfo*/});

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      errorMsg: json['errorMsg'],
      /*additionalInfo: json['additionalInfo'] is String?
          ? {json['additionalInfo']}
          : json['additionalInfo'] ?? {},*/
    );
  }
}
