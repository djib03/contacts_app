import 'package:contacts_app/controller/theme_controller.dart';
import 'package:contacts_app/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Mon Profil")),
      drawer: ModernDrawer(
        onThemeChanged: (bool isDark) {
          Provider.of<ThemeModel>(context, listen: false).toggle();
        },
        isDarkMode: themeModel.isDark,
        currentPage: 'profile',
        onPageSelected: (page) {},
      ),
      body: Center(child: Text("Page de Profil")),
    );
  }
}
