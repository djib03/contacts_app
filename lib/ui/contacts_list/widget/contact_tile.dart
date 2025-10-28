import 'package:contacts_app/data/contact.dart';
import 'package:contacts_app/ui/contact/contact_edit_page.dart';
import 'package:flutter/material.dart';

class ContactTile extends StatelessWidget {
  const ContactTile({
    super.key,
    required this.contacts,
    required this.onFavoritePresssed,
    required this.contactIndex,
  });
  final Contact contacts;
  final void Function() onFavoritePresssed;
  final int contactIndex;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(contacts.name, style: TextStyle(fontSize: 24)),
      subtitle: Text(contacts.email),
      trailing: IconButton(
        icon: Icon(
          contacts.isFavorite ? Icons.star : Icons.star_border,
          color: contacts.isFavorite ? Colors.amber : null,
        ),
        onPressed: onFavoritePresssed,
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder:
                (context) => ContactEditPage(
                  editedContact: contacts,
                  editedContactIndex: contactIndex,
                ),
          ),
        );
      },
    );
  }
}
