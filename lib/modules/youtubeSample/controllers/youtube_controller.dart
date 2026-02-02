import '../model/youtube_video.dart';
import '../services/youtube_api_service.dart';
import 'package:get/get.dart';


class YouTubeController extends GetxController {
  final YouTubeApiService api;

  YouTubeController(this.api);

  var videos = <YouTubeVideo>[].obs;
  var nextPageToken = ''.obs;
  var isLoading = false.obs;

  final String uploadsPlaylistId = 'UUAjbXXOyV673M85ei4Phf-g';

  @override
  void onInit() {
    fetchMore();
    super.onInit();
  }

  Future<void> fetchMore() async {
    if (isLoading.value) return;
    isLoading.value = true;

    final data = await api.fetchVideos(
      playlistId: uploadsPlaylistId,
      pageToken: nextPageToken.value.isEmpty ? null : nextPageToken.value,
    );

    nextPageToken.value = data['nextPageToken'] ?? '';

    final items = (data['items'] as List)
        .map((e) => YouTubeVideo.fromJson(e))
        .toList();

    videos.addAll(items);
    isLoading.value = false;
  }
}
