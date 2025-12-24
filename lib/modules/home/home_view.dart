// lib/modules/home/home_view.dart
import 'package:flutter/material.dart';
import 'home_controller.dart';
import 'package:get/get.dart' show Get, Inst;
import 'package:flutter/material.dart';
import 'package:youtube_player_embed/youtube_player_embed.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HERO CARD
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(height: 200, child: SimpleYoutubeEmbed()),
            ),

            const SizedBox(height: 24),

            /// UPCOMING YATRAS
            const Text(
              "Upcoming Yatras",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _yatraTile(
                  title: "Pandharpur ",
                  date: "Starts January 16, 2025",
                  image:
                      "https://lh3.googleusercontent.com/aida-public/AB6AXuBE7Lj4_ypPlnzYwF5CAY16nc9wOz6QblnGhBwrYgTXHnMuzkrr6Gd2hnu_4pJAwQFN1a88MLW1MIwm7ZZ7g-OTflFR05soLC8VdKh6y3SBw_up54Tskrzsy2JkV2iNV1BMJ61giv5I4kMQQdgTQcHxN0tZDxokzGCjuOP3TLXhz4N2LJ983HDalnd4wTELLQRD8EJbWYd6CAcPhMoIKMNFV1T6OeJlPL58fYGeyK3qE-jQwrz1FfYsQh3ExfVm0kuk3PNXI379SEw",
                  onTap: () {
                    Get.toNamed(Routes.yatraDetails);
                  },
                ),
                _yatraTile(
                  title: "Nirjal Ekdashi",
                  date: "Starts June 24, 2026",
                  image:
                      "https://lh3.googleusercontent.com/aida-public/AB6AXuBE7Lj4_ypPlnzYwF5CAY16nc9wOz6QblnGhBwrYgTXHnMuzkrr6Gd2hnu_4pJAwQFN1a88MLW1MIwm7ZZ7g-OTflFR05soLC8VdKh6y3SBw_up54Tskrzsy2JkV2iNV1BMJ61giv5I4kMQQdgTQcHxN0tZDxokzGCjuOP3TLXhz4N2LJ983HDalnd4wTELLQRD8EJbWYd6CAcPhMoIKMNFV1T6OeJlPL58fYGeyK3qE-jQwrz1FfYsQh3ExfVm0kuk3PNXI379SEw",
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// TRAVEL ESSENTIALS
            /* const Text(
              "Travel Essentials",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),*/
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _EssentialItem(icon: Icons.luggage, label: "Packing List"),
                _EssentialItem(icon: Icons.map, label: "Route Map"),
                _EssentialItem(icon: Icons.support_agent, label: "Support"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget _yatraTile({
    required String title,
    required String date,
    required String image,
    required Function? onTap(),
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
