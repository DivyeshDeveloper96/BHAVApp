import 'dart:io';

import 'package:get/get.dart';
import 'Network Manager/ApiManager.dart';
import 'Network Manager/ApiRequest.dart';
import 'Network Manager/ApiTaskCode.dart';
import 'Network Manager/BaseResponse.dart';
import 'Network Manager/NetworkUtilis.dart';

class BaseController extends GetxController {
  final ApiManager _networkManager = ApiManager();

  @override
  onInit() async {
    super.onInit();
    print("Base controller initialized");
    //loadUserRole();
  }

  @override
  void onReady() {
    super.onReady();
    //loadUserRole();
  }

  /*Future<void> loadUserRole() async {
    final savedRole =
        await SharedPrefManager.instance.getUserRole() ?? UserRole.SpecialEducator;
    userRole.value = savedRole;
    print("Role loaded: $savedRole");
  }*/

  Future<ApiResponse<T>?> makeRequest<T>({
    required ApiRequest request,
    required ApiTaskCode taskcode,
  }) async {
    if (await NetworkUtilis.isInternetConnected()) {
      onPreExecute(taskcode);
      final response = await _networkManager.makeRequest<T>(
        request: request,
        taskcode: taskcode,
      );
      if (response?.isSuccess ?? false) {
        onSuccess(taskcode);
      } else {
        onFailure(taskcode);
      }
      return response;
    } else {
      onNoInternetConnection(taskcode);
      return null;
    }
  }

  Future<ApiResponse<T>?> makeUploadRequest<T>(
      {required ApiRequest request,
      required ApiTaskCode taskcode,
      required File file,
      required String fileKey}) async {
    if (await NetworkUtilis.isInternetConnected()) {
      onPreExecute(taskcode);
      final response = await _networkManager.uploadRequest<T>(
        request: request,
        taskcode: taskcode,
        file: file,
        filedKey: fileKey,
      );
      if (response?.isSuccess ?? false) {
        onSuccess(taskcode);
      } else {
        onFailure(taskcode);
      }
      return response;
    } else {
      onNoInternetConnection(taskcode);
      return null;
    }
  }

  void onNoInternetConnection(ApiTaskCode taskCode) {
    /*UtilsCommon.showToastSnackbar(
        title: "No Internet!",
        msg: "Please connect to the internet",
        type: ToastType.error);*/
  }

  void onPreExecute(ApiTaskCode taskCode) {}

  void onSuccess(ApiTaskCode taskCode) {}

  void onFailure(ApiTaskCode taskCode) {}
}
