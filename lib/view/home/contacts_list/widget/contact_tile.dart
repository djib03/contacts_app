import 'package:contacts_app/model/contact.dart';
import 'package:contacts_app/controller/contact_fake_data.dart';
import 'package:contacts_app/controller/theme_controller.dart';
import 'package:contacts_app/view/home/contact/contact_edit_page.dart';
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
    final themeModel = Provider.of<ThemeModel>(context);

    return Column(
      children: [
        Slidable(
          startActionPane: ActionPane(
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  // Appeler contact
                },
                backgroundColor:
                    themeModel.isDark
                        ? Colors.green.shade900
                        : Colors.green.shade100,
                foregroundColor: Colors.green.shade100,
                icon: Icons.call,
                label: 'Appeler',
                borderRadius: BorderRadius.circular(6),
              ),
            ],
          ),
          endActionPane: ActionPane(
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  Provider.of<ContactModel>(
                    context,
                    listen: false,
                  ).deleteContact(contactIndex);
                },
                backgroundColor:
                    themeModel.isDark
                        ? const Color.fromARGB(255, 84, 17, 17)
                        : Colors.red.shade100,
                foregroundColor: Colors.red.shade600,
                icon: Icons.delete_outline,
                label: 'Supprimer',
                borderRadius: BorderRadius.circular(6),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
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
              splashColor: Colors.teal.withOpacity(0.05),
              highlightColor: Colors.teal.withOpacity(0.02),
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                child: Row(
                  children: [
                    // Avatar amélioré
                    _buildCircleAvatar(
                      Contact(
                        name: contacts.name,
                        phoneNumber: contacts.phoneNumber,
                        email: contacts.email,
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Informations du contact
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            contacts.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color:
                                  themeModel.isDark
                                      ? Colors.white
                                      : Colors.grey.shade900,
                              letterSpacing: 0.2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            contacts.phoneNumber,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color:
                                  themeModel.isDark
                                      ? Colors.grey.shade400
                                      : Colors.grey.shade600,
                              letterSpacing: 0.1,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),

                    // Bouton favori minimaliste
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: onFavoritePresssed,
                        borderRadius: BorderRadius.circular(20),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            contacts.isFavorite
                                ? Icons.star_rounded
                                : Icons.star_outline_rounded,
                            color:
                                contacts.isFavorite
                                    ? Colors.teal.shade400
                                    : Colors.grey.shade400,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Divider subtil
        Padding(
          padding: const EdgeInsets.only(left: 72.0),
          child: Divider(
            height: 1,
            thickness: 0.5,
            color:
                themeModel.isDark ? Colors.grey.shade800 : Colors.grey.shade200,
          ),
        ),
      ],
    );
  }

  Hero _buildCircleAvatar(Contact displayedContact) {
    return Hero(
      tag: 'contact_avatar_${contacts.email}',
      child: Consumer<ThemeModel>(
        builder:
            (context, themeModel, child) => Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors:
                      themeModel.isDark
                          ? [
                            Colors.teal.shade700.withOpacity(0.6),
                            Colors.teal.shade900.withOpacity(0.6),
                          ]
                          : [Colors.teal.shade50, Colors.teal.shade100],
                ),
                border: Border.all(
                  color:
                      themeModel.isDark
                          ? Colors.teal.shade700.withOpacity(0.3)
                          : Colors.teal.shade200.withOpacity(0.5),
                  width: 1.5,
                ),
              ),
              child: CircleAvatar(
                radius: 24,
                backgroundColor: Colors.transparent,
                child: Text(
                  displayedContact.name[0].toUpperCase(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color:
                        themeModel.isDark
                            ? Colors.teal.shade200
                            : Colors.teal.shade700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
