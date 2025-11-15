import 'package:contacts_app/controller/theme_controller.dart';
import 'package:contacts_app/drawer.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class FavoriteContactPage extends StatefulWidget {
  const FavoriteContactPage({super.key});

  @override
  State<FavoriteContactPage> createState() => _FavoriteContactPageState();
}

class _FavoriteContactPageState extends State<FavoriteContactPage> {
  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Mes favoris")),
      drawer: ModernDrawer(
        onThemeChanged: (bool isDark) {
          Provider.of<ThemeModel>(context, listen: false).toggle();
        },
        isDarkMode: themeModel.isDark,
        currentPage: 'favorites',
        onPageSelected: (page) {},
      ),
      body: Center(child: Text("Page des contacts favoris")),
    );
  }
}
