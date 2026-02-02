import 'dart:convert';
import 'package:http/http.dart' as http;

class YouTubeApiService {
  static const _baseUrl = 'https://www.googleapis.com/youtube/v3';
  final String apiKey;

  YouTubeApiService(this.apiKey);

  Future<Map<String, dynamic>> fetchVideos({
    required String playlistId,
    String? pageToken,
  }) async {
    final url = Uri.parse(
      '$_baseUrl/playlistItems'
          '?part=snippet'
          '&maxResults=10'
          '&playlistId=$playlistId'
          '&pageToken=${pageToken ?? ''}'
          '&key=$apiKey',
    );

    final res = await http.get(url);
    return jsonDecode(res.body);
  }
}
