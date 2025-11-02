import 'package:contacts_app/view/contact/widget/contact_form.dart';
import 'package:flutter/material.dart';

class ContactCreatePage extends StatelessWidget {
  const ContactCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text('Ajouter nouveau contact'),
        backgroundColor: Colors.teal,
      ),
      body: ContactForm(),
    );
  }
}
