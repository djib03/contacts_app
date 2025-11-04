import 'package:contacts_app/view/contact/contact_create_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widget/contact_tile.dart';
import 'package:contacts_app/controller/contact_fake_data.dart';
import 'package:contacts_app/controller/theme_controller.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage({super.key});

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  @override
  Widget build(BuildContext context) {
    final contactModel = Provider.of<ContactModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
        actions: [
          // Theme toggle
          Consumer<ThemeModel>(
            builder:
                (context, themeModel, _) => IconButton(
                  tooltip:
                      themeModel.isDark
                          ? 'Activer le thème clair'
                          : 'Activer le thème sombre',
                  icon: Icon(
                    themeModel.isDark ? Icons.wb_sunny : Icons.nights_stay,
                    color: Colors.white,
                  ),
                  onPressed: () => themeModel.toggle(),
                ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: contactModel.contacts.length,
        itemBuilder: (context, index) {
          return ContactTile(
            contacts: contactModel.contacts[index],
            contactIndex: index,
            onFavoritePresssed: () {
              contactModel.changeFavoriteStatus(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => ContactCreatePage()));
        },
        child: Icon(Icons.person_add, color: Colors.white),
      ),
    );
  }
}
