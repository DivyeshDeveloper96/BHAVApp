// lib/modules/home/home_view.dart
import 'dart:math';

import 'package:bhavapp/core/paginatedListview/paginatedListView.dart';
import 'package:bhavapp/modules/home/controllers/home_controller.dart';
import 'package:bhavapp/modules/youtubeSample/model/youtube_video.dart';
import 'package:bhavapp/routes/page_identifier.dart';
import 'package:bhavapp/utils/utilsCommon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show Get, Inst;
import 'package:youtube_player_embed/youtube_player_embed.dart';
import 'package:get/get.dart';
import '../../../widgets/customImageLoader.dart';
import '../../../widgets/dashboard_carousel.dart';
import '../../youtubeSample/controllers/youtube_controller.dart';
import '../../youtubeSample/pages/youtubeplayerpage.dart';
import '../../youtubeSample/services/youtube_api_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController homeController = Get.put(HomeController());
  YouTubeController controller = Get.put(
    YouTubeController(
      YouTubeApiService('AIzaSyCuyQEOoxGKZCtrFd4CTRQ9DW-BSGrAtys'),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DashboardCarousel(),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "YouTube videos",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(PageIdentifier.youtubepage.name);
                      },
                      child: Text(
                        "View All",
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Horizontal YouTube Videos List
              Obx(
                () => SizedBox(
                  height: 200, // Fixed height for horizontal list
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    scrollDirection: Axis.horizontal,
                    itemCount: min(controller.videos.length, 3),
                    itemBuilder: (context, index) {
                      final YouTubeVideo video = controller.videos[index];
                      return _buildCompactVideoCard(video, context);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Upcoming Yatras",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 12),
              // Yatra List - Use shrinkWrap for nested scrolling
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  // Important: allows nesting in ScrollView
                  physics: const NeverScrollableScrollPhysics(),
                  // Disable its own scrolling
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: homeController.items.length,
                  itemBuilder: (context, index) {
                    final item = homeController.items[index];
                    return _yatraTile(
                      title: item.name ?? "",
                      date:
                          "${UtilsCommon.formatDateAs(item.yatraStartAt ?? "", "dd MMM yyyy")} to ${UtilsCommon.formatDateAs(item.yatraEndAt ?? "", "dd MMM yyyy")}",
                      image: item.imageUrl ?? "",
                      onTap: () {
                        Get.toNamed(
                          PageIdentifier.yatraDetails.name,
                          arguments: item.id,
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _yatraTile({
    required String title,
    required String date,
    required String image,
    required Function? Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CustomImageLoader(imageUrl: image, width: 80, height: 80),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),
            const CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xFFF1F1F1),
              child: Icon(Icons.arrow_forward, size: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactVideoCard(YouTubeVideo video, BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => YouTubePlayerPage(videoId: video.videoId)),
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      video.thumbnail,
                      width: 140,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 140,
                          height: 80,
                          color: Colors.grey[300],
                          child: const Icon(Icons.play_circle_outline),
                        );
                      },
                    ),
                  ),
                  /*if (video.duration != null)
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text(
                          video.duration,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),*/
                ],
              ),

              const SizedBox(width: 12),

              // Video info
              /* Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    */
              /*if (video.description != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          video.description,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),*/
              /*

                    const SizedBox(height: 4),

                   */
              /* Row(
                      children: [
                        if (video.viewCount != null)
                          Text(
                            _formatViews(video.viewCount),
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[600],
                            ),
                          ),
                        if (video.viewCount != null && video.publishedAt != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              '•',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ),
                        if (video.publishedAt != null)
                          Text(
                            _formatDate(video.publishedAt),
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[600],
                            ),
                          ),
                      ],
                    ),*/
              /*
                  ],
                ),
              ),*/

              /* IconButton(
                icon: const Icon(Icons.more_vert, size: 20),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () => _showVideoOptions(context, video),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}

class _EssentialItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _EssentialItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF3E8FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, size: 30, color: Color(0xFF6B46C1)),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class SimpleYoutubeEmbed extends StatelessWidget {
  const SimpleYoutubeEmbed({super.key});

  @override
  Widget build(BuildContext context) {
    return
    /// YOUTUBE VIDEO
    AspectRatio(
      aspectRatio: 16 / 9,
      child: YoutubePlayerEmbed(
        videoId: "watch?v=Xepp0iaPcJI",
        autoPlay: false,
        mute: false,
      ),
    );
  }
}
