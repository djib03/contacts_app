import 'dart:io';
import 'package:contacts_app/model/contact.dart';
import 'package:contacts_app/controller/contact_fake_data.dart';
import 'package:contacts_app/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ContactForm extends StatefulWidget {
  final Contact? editedContact;
  final int? editedContactIndex;

  const ContactForm({super.key, this.editedContact, this.editedContactIndex});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  //key allow us to acces widget from a different place in the code
  final _formKey = GlobalKey<FormState>();

  File? _pickedImage;

  //this fiel will be gotten from the form
  String? _name;
  String? _email;
  String? _phoneNumber;

  bool get isEditing => widget.editedContact != null;

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagefile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (imagefile != null) {
      setState(() {
        _pickedImage = File(imagefile.path);
      });
      // You can now use _pickedImage for display or upload
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            _buildContactPicture(),
            SizedBox(height: 20),
            TextFormField(
              validator: _validateName,
              initialValue: widget.editedContact?.name,
              decoration: InputDecoration(
                labelText: 'Nom',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onSaved: (value) => _name = value,
            ),
            SizedBox(height: 10),
            TextFormField(
              validator: _validateEmail,
              initialValue: widget.editedContact?.email,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onSaved: (value) => _email = value,
            ),
            SizedBox(height: 10),
            TextFormField(
              validator: _validatePhoneNumber,
              initialValue: widget.editedContact?.phoneNumber,
              decoration: InputDecoration(
                labelText: 'Numéro de téléphone',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onSaved: (value) => _phoneNumber = value,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              onPressed: () {
                onSaveContactButtonPressed();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Enregistrer',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactPicture() {
    final halfScreenDiameter = MediaQuery.of(context).size.width / 2;
    // Avoid forcing non-null with '!' here. Use the nullable value and
    // provide a sensible default if the contact or its name is null/empty.
    final name = widget.editedContact?.name;
    final initial = (name != null && name.isNotEmpty) ? name[0] : '';
    return GestureDetector(
      onTap: () {
        _pickImage();
      },
      child: Hero(
        tag: 'contact_avatar_${widget.editedContact?.email}',
        child: Consumer<ThemeModel>(
          builder:
              (context, themeModel, child) => CircleAvatar(
                backgroundColor:
                    themeModel.isDark
                        ? Colors.grey.shade800
                        : Colors.teal.shade50,
                foregroundColor: Colors.teal,
                radius: halfScreenDiameter / 2,
                child:
                    isEditing && _pickedImage == null
                        ? Text(
                          initial,
                          style: TextStyle(fontSize: halfScreenDiameter / 2),
                        )
                        : (_pickedImage != null
                            ? ClipRRect(
                              borderRadius: BorderRadius.circular(90),
                              child: Image.file(
                                _pickedImage!,
                                width: halfScreenDiameter,
                                height: halfScreenDiameter,
                                fit: BoxFit.cover,
                              ),
                            )
                            : Icon(
                              Icons.person,
                              size: halfScreenDiameter / 2,
                              color: Colors.teal,
                            )),
              ),
        ),
      ),
    );
  }

  //validators either return null or error message
  //if the value is not valid, return an error message
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Le nom est requis';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'L\'email est requis';
    }
    //regex for email validation
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    if (!emailRegex.hasMatch(value)) {
      return 'L\'email n\'est pas valide';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    // Regex for phone number validation (simple version)
    final phoneRegex = RegExp(
      r'^\+?\d{1,3}[ .-]?\(?\d{1,4}\)?([ .-]?\d{2,4}){2,4}$',
    );
    if (!phoneRegex.hasMatch(value!)) {
      return 'Le numéro de téléphone n\'est pas valide';
    }
    return null;
  }

  void onSaveContactButtonPressed() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newContact = Contact(
        name: _name!,
        email: _email!,
        phoneNumber: _phoneNumber!,
        // If we're adding a brand new contact, editedContact may be null.
        // Use its isFavorite when present, otherwise default to false.
        isFavorite: widget.editedContact?.isFavorite ?? false,
      );

      if (isEditing) {
        Provider.of<ContactModel>(
          context,
          listen: false,
        ).updateContact(widget.editedContactIndex!, newContact);
        Navigator.of(context).pop();
        return;
      } else {}
      Provider.of<ContactModel>(context, listen: false).addContact(newContact);
      Navigator.of(context).pop();
    }
  }
}
