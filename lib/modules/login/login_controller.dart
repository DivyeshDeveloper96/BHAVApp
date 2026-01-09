import 'package:bhavapp/core/network/Base/BaseController.dart';
import 'package:bhavapp/shared/commonControllers.dart';

import '../../core/network/Base/Network Manager/ApiGenerator.dart';
import '../../core/network/Base/Network Manager/ApiTaskCode.dart';

class LoginController extends BaseController {
  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> loginAPI(String mobile) async {
    var body = {"phone": mobile};
    bool val = await CommonController().loginSendOTP(body);
    return val;
  }
}
