// lib/modules/dashboard/dashboard_view.dart
import 'package:bhavapp/modules/yatras/contactUs_view.dart';
import 'package:bhavapp/modules/yatras/myRegistrations_view.dart';
import 'package:bhavapp/modules/yatras/yatraDetails_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home/home_view.dart';
import '../settings/settings_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int selectedIndex = 0;
  final List<Widget> pages = [HomeView(), MyRegistrationsView(), ContactView()];

  final List<String> drawerTitles = ["Home", "My Registrations", "Contact Us"];

  void onItemTapped(int index) {
    setState(() => selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(drawerTitles[selectedIndex])),
      /*drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text('Menu')),
            ListTile(
              selected: selectedIndex == 0,
              title: const Text('Home'),
              onTap: () {
                onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              selected: selectedIndex == 1,
              title: const Text('Settings'),
              onTap: () {
                onItemTapped(1);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),*/
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            label: 'My Registraions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.support_agent_outlined),
            label: 'Contact Us',
          ),
        ],
      ),
    );
  }
}
