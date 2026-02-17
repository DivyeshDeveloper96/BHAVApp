import 'package:bhavapp/core/network/Base/BaseController.dart';
import 'package:bhavapp/modules/yatras/model/yatraDetails_model.dart';
import 'package:bhavapp/shared/commonControllers.dart';
import 'package:get/get.dart';
import '../../../core/network/Base/Network Manager/ApiGenerator.dart';
import '../../../core/network/Base/Network Manager/ApiTaskCode.dart';
import '../../../utils/utilsCommon.dart';

class YatraDetailsController extends BaseController {
  RxString yatraId = "".obs;

  Rx<YatraDetailsModel?> yatraDetailsResp = YatraDetailsModel().obs;
  RxBool isLoading = true.obs;

  init() async {
    await getYatraDetailsAPI();
  }

  getYatraDetailsAPI() async {
    isLoading.value = true;
    final response = await makeRequest<YatraDetailsModel>(
      request: ApiGenerator.getYatraDeatils(yatraId.value),
      taskcode: ApiTaskCode.getYatraDetails,
    );
    if (response?.isSuccess ?? false) {
      isLoading.value = false;
      print("✅ Success: ${response?.responseMessage}");
      yatraDetailsResp.value = response!.data!;
      return response.data!;
    } else {
      isLoading.value = false;
      print("❌ Failed: ${response?.responseMessage}");
      UtilsCommon.showSnackbarOnSuccessnFail(
        "${response?.responseMessage}",
        false,
      );
      return false;
    }
  }

  Future<String> loadHtml() async {
    return yatraDetailsResp.value!.yatraContentBlock![0].contentHtml!;
  }
}
