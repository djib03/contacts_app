import 'package:contacts_app/view/auth/Login_choice.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Créer un compte'), elevation: 0),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: ListView(
            children: [
              Text(
                "Créer un compte",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade200,
                ),
              ),
              SizedBox(height: 40),

              TextField(
                decoration: InputDecoration(
                  focusColor: Colors.teal,
                  fillColor: Colors.teal.shade50,
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Prénom',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Nom',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
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
                  // padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text("S'inscrire"),
              ),
              SizedBox(height: 6),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginChoice()),
                  );
                },
                style: TextButton.styleFrom(
                  // overlayColor: Colors.transparent,
                  foregroundColor: Colors.teal,
                  textStyle: TextStyle(decoration: TextDecoration.underline),
                ),
                child: Text("Deja un compte? Connectez-vous"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
