import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaLinksPage extends StatelessWidget {
  const SocialMediaLinksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Section
            /*Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
              child: Column(
                children: [
                  const Text(
                    'Stay updated with our spiritual journey',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF131118),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Follow us for daily darshan updates and yatra schedules.',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),*/

            // Social Media Section
            _buildSection('SOCIAL MEDIA', [
              _SocialLink(
                icon: null,
                assetsPath: "assets/images/fb2.webp",
                title: 'Facebook',
                buttonText: 'Follow',
                onTap: () => _launchURL('https://www.facebook.com/bavswami/'),
              ),
              _SocialLink(
                icon: null,
                assetsPath: "assets/images/insta2.webp",
                title: 'Instagram',
                buttonText: 'Follow',
                onTap:
                    () => _launchURL(
                      'https://www.instagram.com/vaisnavaswami/?hl=en',
                    ),
              ),
              _SocialLink(
                icon: null,
                assetsPath: "assets/images/youtube1.webp",
                title: 'YouTube',
                buttonText: 'Subscribe',
                onTap:
                    () => _launchURL('https://www.youtube.com/@vaisnavaswami'),
              ),
              _SocialLink(
                icon: null,
                assetsPath: "assets/images/social.webp",
                title: 'Website',
                buttonText: 'Open',
                onTap: () => _launchURL('https://vaisnavaswami.com/'),
              ),
            ]),

            // Direct Support Section
            _buildSection('DIRECT SUPPORT', [
              _SocialLink(
                icon: null,
                assetsPath: "assets/images/whatsapp.webp",
                title: 'WhatsApp Channel',
                subtitle: 'Join for live updates',
                buttonText: 'Join',
                onTap:
                    () => _launchURL(
                      'https://www.whatsapp.com/channel/0029VadVPUW1t90epeLC9p3C',
                    ),
              ),
              _SocialLink(
                icon: Icons.mail,
                title: 'Email Support',
                subtitle: 'bavsofficemanager@gmail.com',
                buttonText: 'Send',
                isSecondary: true,
                onTap: () => _launchURL('mailto:bavsofficemanager@gmail.com'),
              ),
              _SocialLink(
                icon: Icons.call,
                title: 'Toll-Free Support',
                subtitle: '24/7 Yatra Assistance',
                buttonText: 'Call',
                onTap: () => _launchURL('tel:+918001234567'),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<_SocialLink> links) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12, top: 8),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.grey[500],
                letterSpacing: 1.2,
              ),
            ),
          ),
          ...links.map(
            (link) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: link,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _SocialLink extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String? subtitle;
  final String buttonText;
  final bool isSecondary;
  final VoidCallback onTap;
  final String? assetsPath;

  const _SocialLink({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.buttonText,
    this.isSecondary = false,
    required this.onTap,
    this.assetsPath,
  });

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF7c3bed);
    const secondaryColor = Color(0xFFCABFD);

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: primaryColor.withOpacity(0.15), width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // Icon
              Container(
                width: 40,
                height: 40,
                decoration:
                    icon != null
                        ? BoxDecoration(
                          color: primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        )
                        : null,
                child:
                    icon == null
                        ? Image.asset(assetsPath!, height: 20, width: 20)
                        : Icon(icon, color: primaryColor, size: 20),
              ),

              const SizedBox(width: 16),

              // Title & Subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // Button
              ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSecondary ? secondaryColor : primaryColor,
                  foregroundColor: isSecondary ? primaryColor : Colors.white,
                  elevation: 0,
                  minimumSize: const Size(84, 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                child: Text(
                  buttonText,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSecondary ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
