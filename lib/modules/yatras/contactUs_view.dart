import 'package:bhavapp/core/themes/colorConstants.dart';
import 'package:flutter/material.dart';

class ContactView extends StatelessWidget {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text(
            "We're here to help you on your journey.",
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 16),
          _ContactTile(
            icon: Icons.forum,
            title: "General Inquiries",
            subtitle: "For pre-yatra questions",
          ),
          _ContactTile(
            icon: Icons.smartphone,
            title: "Technical Support",
            subtitle: "For app-related issues",
          ),
          Divider(),
          _ContactTile(
            icon: Icons.person,
            title: "Yatra Coordinator",
            subtitle: "Main point of contact",
          ),
          _ContactTile(
            icon: Icons.emergency,
            title: "Emergency Contact",
            subtitle: "For urgent situations",
            danger: true,
          ),
        ],
      ),
    );
  }
}

class _ContactTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool danger;

  const _ContactTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.danger = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = danger ? Colors.red : ColorConstant.kPrimary;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(.15),
        child: Icon(icon, color: color),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        onPressed: () {},
        child: const Text("Call"),
      ),
    );
  }
}

