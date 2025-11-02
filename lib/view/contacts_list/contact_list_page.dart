import 'package:contacts_app/view/contact/contact_create_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widget/contact_tile.dart';
import 'package:contacts_app/model/contact_model.dart';

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
