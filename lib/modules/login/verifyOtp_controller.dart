import 'package:bhavapp/core/network/Base/BaseController.dart';
import 'package:bhavapp/modules/login/verifyOtpModel.dart';
import 'package:bhavapp/shared/shared_pref_manager.dart';

import '../../shared/commonControllers.dart';
import '../../shared/shared_pref_key.dart';

class VerifyOtpController extends BaseController {
  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> verifyOtpAPI(String phone, String otp) async {
    var body = {"phone": phone, "token": otp};
    final res = await CommonController().verifyOtp(body);
    if (res != null) {
      final VerifyOtpModel val =
          res is VerifyOtpModel ? res : VerifyOtpModel.fromJson(res);
      SharedPrefManager.instance.setLoginStatus(true);
      SharedPrefManager.instance.setAccessToken(val.accessToken ?? "");
      SharedPrefManager.instance.setUserModel(val);
      return true;
    }
    return false;
  }
}
