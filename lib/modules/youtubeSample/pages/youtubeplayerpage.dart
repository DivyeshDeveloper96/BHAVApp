import 'package:flutter/cupertino.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubePlayerPage extends StatelessWidget {
  final String videoId;

  YouTubePlayerPage({required this.videoId});

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(autoPlay: true),
      ),
      showVideoProgressIndicator: true,
    );
  }
}
