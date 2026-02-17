import 'package:bhavapp/core/paginatedListview/basePaginatedController.dart';
import 'package:bhavapp/modules/youtubeSample/model/youtube_video.dart';
import 'package:get/get.dart';
import '../../../core/network/Base/Network Manager/ApiGenerator.dart';
import '../../../core/network/Base/Network Manager/ApiTaskCode.dart';
import '../../../utils/utilsCommon.dart';
import '../model/youtubeListModel.dart';

class YouTubeController extends BasePaginatedController<YouTubeListModel> {
  RxList<YouTubeListModel> videlList = <YouTubeListModel>[].obs;

  YouTubeController() {
    useTokenPagination = true; // Enable token-based pagination
  }

  @override
  Future<Map<String, dynamic>> fetchPageWithToken(
    String? pageToken,
    String query,
  ) async {
    final response = await makeRequest<Map<String, dynamic>>(
      request: ApiGenerator.getYoutubeList(pageToken: pageToken),
      taskcode: ApiTaskCode.getYoutubeList,
    );

    if (response?.isSuccess ?? false) {
      print("Success: ${response?.responseMessage}");
      return {
        /*'items': response ?? [],
        'nextPageToken': response['nextPageToken'] ?? '',*/
      };
    } else {
      print("Failed: ${response?.responseMessage}");
      UtilsCommon.showToastSnackbar(
        title: "Alert",
        msg: response?.responseMessage ?? "",
        type: ToastType.warning,
      );
      return {'items': <YouTubeListModel>[], 'nextPageToken': ''};
    }
  }

  @override
  Future<List<YouTubeListModel>> fetchPage(int page, String query) async {
    // Not used when useTokenPagination is true
    throw UnimplementedError(
      'Use fetchPageWithToken for token-based pagination',
    );
  }
}
