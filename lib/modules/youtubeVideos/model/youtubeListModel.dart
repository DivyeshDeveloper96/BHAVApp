class YouTubeListModel {
  final String videoId;
  final String title;
  final String thumbnail;

  YouTubeListModel({
    required this.videoId,
    required this.title,
    required this.thumbnail,
  });

  factory YouTubeListModel.fromJson(Map<String, dynamic> json) {
    return YouTubeListModel(
      videoId: json['snippet']['resourceId']['videoId'],
      title: json['snippet']['title'],
      thumbnail: json['snippet']['thumbnails']['medium']['url'],
    );
  }
}
