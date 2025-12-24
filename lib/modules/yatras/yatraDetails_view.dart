import 'dart:convert';

import 'package:bhavapp/core/themes/colorConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../widgets/child_scaffold.dart';

/*class YatradetailsView extends StatelessWidget {
  const YatradetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldChild(
      actions: [],
      title: "Yatra Details",
      body: FutureBuilder<String>(
        future: loadHtmlFromJson(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          return Html(data: snapshot.data!);
        },
      ),
    );
  }

  Future<String> loadHtmlFromJson() async {
    final jsonString = await rootBundle.loadString('assets/tempContent.json');
    final jsonData = jsonDecode(jsonString);
    return jsonData['html_content']; // IMPORTANT
  }
}*/


class YatraDetailsView extends StatelessWidget {
  const YatraDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(bottom: 140),
            children: const [
              _YatraHeader(),
              _YatraOverview(),
              _YatraHighlights(),
              _YatraInfoList(),
            ],
          ),
        ],
      ),
    );
  }
}

class _YatraHeader extends StatelessWidget {
  const _YatraHeader();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 220,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                "https://images.unsplash.com/photo-1501785888041-af3ef285b470",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned.fill(
          child: Container(color: Colors.black45),
        ),
        const Positioned(
          bottom: 20,
          left: 16,
          child: Text(
            "Sacred Himalayan Pilgrimage",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}


class _YatraOverview extends StatelessWidget {
  const _YatraOverview();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        "A journey of spirit and discovery through the majestic Himalayas.",
        style: TextStyle(fontSize: 15, color: Colors.grey),
      ),
    );
  }
}


class _YatraHighlights extends StatelessWidget {
  const _YatraHighlights();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        _Highlight(icon: Icons.calendar_today, label: "7 Days"),
        _Highlight(icon: Icons.trending_up, label: "Moderate"),
        _Highlight(icon: Icons.landscape, label: "Himalayas"),
      ],
    );
  }
}

class _Highlight extends StatelessWidget {
  final IconData icon;
  final String label;

  const _Highlight({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: ColorConstant.kPrimary.withOpacity(.15),
          child: Icon(icon, color: ColorConstant.kPrimary),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}


class _YatraInfoList extends StatelessWidget {
  const _YatraInfoList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _InfoTile(
          icon: Icons.luggage,
          title: "What to Pack",
          subtitle: "Warm clothes, sturdy boots",
        ),
        _InfoTile(
          icon: Icons.cloud,
          title: "Best Time",
          subtitle: "April to June",
        ),
        _InfoTile(
          icon: Icons.check_circle,
          title: "Inclusions",
          subtitle: "Meals, stay, guide",
        ),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _InfoTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: ColorConstant.kPrimary.withOpacity(.15),
        child: Icon(icon, color: ColorConstant.kPrimary),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
    );
  }
}
