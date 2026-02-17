import 'package:bhavapp/core/network/Base/BaseController.dart';
import 'package:bhavapp/core/paginatedListview/basePaginatedController.dart';
import 'package:bhavapp/modules/home/model/yatraListModel.dart';
import '../../../core/network/Base/Network Manager/ApiGenerator.dart';
import '../../../core/network/Base/Network Manager/ApiTaskCode.dart';
import 'package:get/get.dart';
import '../../../utils/utilsCommon.dart';

class HomeController extends BasePaginatedController<YatraListModel> {
  RxList<YatraListModel> yatraList = <YatraListModel>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  Future<List<YatraListModel>> fetchPage(int page, String query) async {
    final response = await makeRequest<List<YatraListModel>>(
      request: ApiGenerator.getYatraList(),
      taskcode: ApiTaskCode.getYatraList,
    );
    if (response?.isSuccess ?? false) {
      yatraList.value = response!.data!;
      return yatraList.value;
    } else {
      UtilsCommon.showCustomSnackBar(
        Get.context!,
        isSuccess: true,
        message: response!.responseMessage,
      );
      return [];
    }
  }


}
