import 'package:contacts_app/data/contact.dart';
import 'package:contacts_app/model/contact_model.dart';
import 'package:contacts_app/view/contact/contact_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

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
    return Slidable(
      endActionPane: ActionPane(
        motion: StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              Provider.of<ContactModel>(
                context,
                listen: false,
              ).deleteContact(contactIndex);
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Supprimer',
          ),
        ],
      ),

      child: ListTile(
        title: Text(contacts.name, style: TextStyle(fontSize: 20)),
        subtitle: Text(contacts.email),
        //display first letter of name in circle avatar
        leading: _buildCircleAvatar(
          Contact(
            name: contacts.name,
            email: contacts.email,
            phoneNumber: contacts.phoneNumber,
          ),
        ),
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
      ),
    );
  }

  Hero _buildCircleAvatar(Contact displayedContact) {
    return Hero(
      tag: 'contact_avatar_${contacts.email}',
      child: CircleAvatar(
        backgroundColor: Colors.teal.shade50,
        foregroundColor: Colors.teal,
        child: Text(displayedContact.name[0]),
      ),
    );
  }
}
