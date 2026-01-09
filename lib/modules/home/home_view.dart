// lib/modules/home/home_view.dart
import 'package:bhavapp/core/paginatedListview/paginatedListView.dart';
import 'package:bhavapp/modules/home/home_controller.dart';
import 'package:bhavapp/utils/utilsCommon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show Get, Inst;
import 'package:youtube_player_embed/youtube_player_embed.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HERO CARD
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(height: 250, child: SimpleYoutubeEmbed()),
            ),
            const SizedBox(height: 24),
            const Text(
              "Upcoming Yatras",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: PaginatedListView(
                isShowSearch: false,
                controller: homeController,
                noListMessage: "No Data Found!",
                itemBuilder:
                    (context, item) => _yatraTile(
                      title: item.name ?? "",
                      date:
                          "${UtilsCommon.formatDateAs(item.yatraStartAt ?? "", "dd MMM yyyy")} to ${UtilsCommon.formatDateAs(item.yatraEndAt ?? "", "dd MMM yyyy")}" ??
                          "",
                      image: /*item.imageUrl ?? */ "https://picsum.photos/200",
                      onTap: () {
                        Get.toNamed(Routes.yatraDetails);
                      },
                    ),
              ),
            ),
            const SizedBox(height: 24),
          ],
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
              child: Image.network(
                image,
                height: 70,
                width: 70,
                fit: BoxFit.cover,
              ),
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
