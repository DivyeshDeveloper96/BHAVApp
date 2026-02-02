import 'package:bhavapp/modules/youtubeSample/pages/youtubeplayerpage.dart';
import 'package:bhavapp/widgets/child_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/youtube_controller.dart';
import '../model/youtube_video.dart';
import '../services/youtube_api_service.dart';

class YouTubeListPage extends StatelessWidget {
  final controller = Get.put(
    YouTubeController(
      YouTubeApiService('AIzaSyCuyQEOoxGKZCtrFd4CTRQ9DW-BSGrAtys'),
    ),
  );

  /* @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My YouTube Videos')),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.videos.length + 1,
          itemBuilder: (context, index) {
            if (index == controller.videos.length) {
              controller.fetchMore();
              return const Center(child: CircularProgressIndicator());
            }

            final video = controller.videos[index];
            return ListTile(
              leading: Image.network(video.thumbnail),
              title: Text(video.title),
              onTap:
                  () => Get.to(() => YouTubePlayerPage(videoId: video.videoId)),
            );
          },
        ),
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return AppScaffoldChild(
      actions: [],
      title: "YouTube Videos",
      body: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.videos.length + 1,
          itemBuilder: (context, index) {
            if (index == controller.videos.length) {
              controller.fetchMore();
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: CircularProgressIndicator(),
                ),
              );
            }

            YouTubeVideo video = controller.videos[index];
            return _buildVideoCard(video, context);
          },
        ),
      ),
    );
  }

  Widget _buildVideoCard(YouTubeVideo video, BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => YouTubePlayerPage(videoId: video.videoId)),
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail with duration badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Image.network(
                    video.thumbnail,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: double.infinity,
                        height: 200,
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.play_circle_outline,
                          size: 64,
                          color: Colors.grey,
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        width: double.infinity,
                        height: 200,
                        color: Colors.grey[200],
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    },
                  ),
                ),

                /*// Duration badge (if available)
                if (video.duration != null)
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        video.duration,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),*/

                // Play overlay on hover (optional)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.1),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Video info
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    video.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 8),

                  /* // Description (if available)
                  if (video.description != null && video.description.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        video.description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),*/

                  /*  // Metadata row
                  Row(
                    children: [
                      // Views count (if available)
                      if (video.viewCount != null) ...[
                        Icon(Icons.visibility, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          _formatViews(video.viewCount),
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],

                      // Upload date (if available)
                      if (video.publishedAt != null) ...[
                        Icon(Icons.schedule, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          _formatDate(video.publishedAt),
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],

                      const Spacer(),

                      // More options
                      IconButton(
                        icon: const Icon(Icons.more_vert, size: 20),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          _showVideoOptions(context, video);
                        },
                      ),
                    ],
                  ),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to format views count
  String _formatViews(int views) {
    if (views >= 1000000) {
      return '${(views / 1000000).toStringAsFixed(1)}M views';
    } else if (views >= 1000) {
      return '${(views / 1000).toStringAsFixed(1)}K views';
    }
    return '$views views';
  }

  // Helper method to format date
  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays > 365) {
        return '${(difference.inDays / 365).floor()} years ago';
      } else if (difference.inDays > 30) {
        return '${(difference.inDays / 30).floor()} months ago';
      } else if (difference.inDays > 0) {
        return '${difference.inDays} days ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} hours ago';
      } else {
        return '${difference.inMinutes} minutes ago';
      }
    } catch (e) {
      return dateString;
    }
  }

  // Show video options bottom sheet
  void _showVideoOptions(BuildContext context, dynamic video) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder:
          (context) => Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.share),
                  title: const Text('Share'),
                  onTap: () {
                    Navigator.pop(context);
                    // Implement share functionality
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.playlist_add),
                  title: const Text('Add to playlist'),
                  onTap: () {
                    Navigator.pop(context);
                    // Implement add to playlist
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.download),
                  title: const Text('Download'),
                  onTap: () {
                    Navigator.pop(context);
                    // Implement download
                  },
                ),
              ],
            ),
          ),
    );
  }
}
