import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:contacts_app/data/contact.dart';

class ContactModel extends ChangeNotifier {
  final List<Contact> _contacts = List.generate(5, (index) {
    return Contact(
      name: faker.person.name(),
      email: faker.internet.email(),
      phoneNumber: faker.phoneNumber.us(),
    );
  });

  // Propriété en lecture seule pour exposer la liste des contacts sans permettre sa modification directe depuis l'extérieur.
  List<Contact> get contacts => _contacts;

  void changeFavoriteStatus(int index) {
    _contacts[index].isFavorite = !_contacts[index].isFavorite;

    sortContacts();

    notifyListeners();
  }

  void updateContact(int index, Contact updated) {
    _contacts[index] = updated;
    sortContacts();
    notifyListeners();
  }

  void addContact(Contact contact) {
    _contacts.add(contact);

    sortContacts();

    notifyListeners();
  }

  void sortContacts() {
    _contacts.sort((a, b) {
      // Favoris en haut, puis tri alphabétique
      if (a.isFavorite && !b.isFavorite) return -1;
      if (!a.isFavorite && b.isFavorite) return 1;
      return a.name.compareTo(b.name); // Tri alphabétique
    });
  }
}
