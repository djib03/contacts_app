import 'package:contacts_app/view/auth/signup_screen.dart';
import 'package:contacts_app/view/contacts_list/contact_list_page.dart';
import 'package:flutter/material.dart';

class LoginScreenPhoneNumber extends StatefulWidget {
  const LoginScreenPhoneNumber({super.key});

  @override
  State<LoginScreenPhoneNumber> createState() => _LoginScreenPhoneNumberState();
}

class _LoginScreenPhoneNumberState extends State<LoginScreenPhoneNumber> {
  final phonenumberController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  void dispose() {
    phonenumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Login')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              Text(
                "Se connecter",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade200,
                ),
              ),
              SizedBox(height: 40),
              TextField(
                controller: phonenumberController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone),

                  labelText: 'Numéro de téléphone',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: 'Mot de passe',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {},

                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.teal,
                ),
                child: Text("Se connecter", style: TextStyle(fontSize: 13)),
              ),
              SizedBox(height: 6),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupScreen()),
                  );
                },
                style: TextButton.styleFrom(
                  // overlayColor: Colors.transparent,
                  foregroundColor: Colors.teal,
                  textStyle: TextStyle(decoration: TextDecoration.underline),
                ),
                child: Text("Pas de compte ? Inscrivez-vous"),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: Colors.teal,
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => ContactListPage()),
          );
        },
        child: Icon(Icons.arrow_forward_ios, color: Colors.white),
      ),
    );
  }
}
