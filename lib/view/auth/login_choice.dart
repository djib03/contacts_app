import 'package:contacts_app/view/auth/login_screen_email.dart';
import 'package:flutter/material.dart';
import 'login_screen_phone_number.dart';

class LoginChoice extends StatelessWidget {
  const LoginChoice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.contacts_rounded,
                  size: 50,
                  color: Colors.teal.shade700,
                ),
              ),

              SizedBox(height: 30),
              // title and description
              Text(
                "Choisissez votre méthode de connexion",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                "Vous pouvez vous connecter avec votre email ou votre numéro de téléphone.",
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),

              // button Connexion avec le numéro de téléphone
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreenPhoneNumber(),
                    ),
                  );
                },
                icon: Icon(Icons.phone_android),
                label: Text("Se connecter avec le numéro de téléphone"),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 15),

              // button Connexion avec l'email
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreenEmail()),
                  );
                },
                icon: Icon(Icons.email_outlined),
                label: Text("Se connecter avec l'email"),
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  side: BorderSide(color: Colors.teal.shade100),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
