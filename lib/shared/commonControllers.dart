import 'package:flutter/material.dart';

import '../core/network/Base/BaseController.dart';
import '../core/network/Base/Network Manager/ApiGenerator.dart';
import '../core/network/Base/Network Manager/ApiTaskCode.dart';
import '../modules/login/verifyOtpModel.dart';
import '../utils/utilsCommon.dart';

class CommonController extends BaseController {
  Future<bool> loginSendOTP(
    Map<String, dynamic> body, {
    BuildContext? context,
  }) async {
    final response = await makeRequest<Map<String, dynamic>>(
      request: ApiGenerator.loginSentOtp(body),
      taskcode: ApiTaskCode.loginSentOTP,
    );
    if (response?.isSuccess ?? false) {
      print("✅ Success: ${response?.responseMessage}");
      return true;
    } else {
      print("❌ Failed: ${response?.responseMessage}");
      UtilsCommon.showSnackbarOnSuccessnFail(
        "${response?.responseMessage}",
        false,
      );
      return false;
      // UtilsCommon.customToast(
      //     context ?? Get.context!, response?.responseMessage ?? "");
    }
  }

  Future<dynamic> verifyOtp(
    Map<String, dynamic> body, {
    BuildContext? context,
  }) async {
    final response = await makeRequest<Map<String, dynamic>>(
      request: ApiGenerator.verifyOtp(body),
      taskcode: ApiTaskCode.verifyOTP,
    );
    if (response?.isSuccess ?? false) {
      print("✅ Success: ${response?.responseMessage}");
      return response!.data!;
    } else {
      print("❌ Failed: ${response?.responseMessage}");
      UtilsCommon.showSnackbarOnSuccessnFail(
        "${response?.responseMessage}",
        false,
      );
      return false;
    }
  }
}
