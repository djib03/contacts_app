import 'package:contacts_app/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'ui/contacts_list/contact_list_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ContactModel(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Contacts",
      theme: ThemeData(
        primarySwatch: Colors.teal,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.teal),
          ),
          floatingLabelStyle: TextStyle(color: Colors.teal),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.teal, width: 2),
          ),
        ),
      ),

      home: ContactListPage(),
    );
  }
}
