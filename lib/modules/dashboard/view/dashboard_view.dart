// lib/modules/dashboard/dashboard_view.dart
import 'package:bhavapp/modules/more/socialmedia/view/followUsOnSocialMedia.dart';
import 'package:bhavapp/modules/yatras/view/contactUs_view.dart';
import 'package:bhavapp/modules/yatras/view/myRegistrations_view.dart';
import 'package:flutter/material.dart';
import '../../../shared/AppConstants.dart';
import '../../../shared/shared_pref_key.dart';
import '../../../shared/shared_pref_manager.dart';
import '../../../widgets/AppBottomSheet.dart';
import '../../home/view/home_view.dart';
import '../../login/view/login_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int selectedIndex = 0;
  final List<Widget> pages = [
    HomeView(),
    MyRegistrationsView(),
    SocialMediaLinksPage(),
  ];

  final List<String> drawerTitles = ["Home", "My Registrations", "Contact Us"];

  @override
  void initState() {
    super.initState();
    _loadLoginState();
  }

  void _loadLoginState() async {
    final logged = await SharedPrefManager.instance.isLoggedIn();
    IS_LOGGEDIN = logged;
  }

  void onItemTapped(int index) async {
    if (index == 1) {
      if (!IS_LOGGEDIN) {
        showLoginBottomSheet(context);
        return;
      }
    }
    setState(() => selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(drawerTitles[selectedIndex]),
        actions: [
          Visibility(
            visible: IS_LOGGEDIN,
            child: IconButton(
              icon: Icon(Icons.logout_outlined),
              onPressed: () {},
            ),
          ),
        ],
      ),
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

  void showLoginBottomSheet(BuildContext context) {
    AppBottomSheet.show(context, title: "Login", child: LoginView());
  }
}
