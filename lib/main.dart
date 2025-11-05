import 'package:contacts_app/controller/contact_fake_data.dart';
import 'package:contacts_app/controller/theme_controller.dart';
import 'package:contacts_app/view/auth/Login_choice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ContactModel()),
        ChangeNotifierProvider(create: (_) => ThemeModel()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    return MaterialApp(
      title: "Contacts",
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeModel.mode,
      home: LoginChoice(),
    );
  }
}
