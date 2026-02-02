class YouTubeVideo {
  final String videoId;
  final String title;
  final String thumbnail;

  YouTubeVideo({
    required this.videoId,
    required this.title,
    required this.thumbnail,
  });

  factory YouTubeVideo.fromJson(Map<String, dynamic> json) {
    return YouTubeVideo(
      videoId: json['snippet']['resourceId']['videoId'],
      title: json['snippet']['title'],
      thumbnail: json['snippet']['thumbnails']['medium']['url'],
    );
  }
}
