import 'package:contacts_app/data/contact.dart';
import 'package:contacts_app/ui/contact/widget/contact_form.dart';
import 'package:flutter/material.dart';

class ContactEditPage extends StatelessWidget {
  final Contact editedContact;
  final int editedContactIndex;

  const ContactEditPage({
    super.key,
    required this.editedContact,
    required this.editedContactIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier contact'),
        backgroundColor: Colors.teal,
      ),
      body: ContactForm(
        editedContact: editedContact,
        editedContactIndex: editedContactIndex,
      ),
    );
  }
}
