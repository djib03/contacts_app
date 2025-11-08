import 'package:contacts_app/view/auth/signup_screen.dart';
import 'package:contacts_app/view/home/contacts_list/contact_list_page.dart';
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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.all(8),
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.teal.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.phone_android_rounded,
                    color: Colors.teal.shade800,
                    size: 60,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Se connecter",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade800,
                  ),
                ),
                SizedBox(height: 25),

                // champs num de tel
                TextField(
                  controller: phonenumberController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone, color: Colors.teal),
                    labelText: 'Numéro de téléphone',
                    labelStyle: TextStyle(color: Colors.teal.shade700),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.teal.shade400,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 16),

                //champs mot de passe
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Colors.teal),
                    labelText: 'Mot de passe',
                    labelStyle: TextStyle(color: Colors.teal),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 30),

                // Button se connecter
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.login, color: Colors.white),
                  label: Text("Se connecter", style: TextStyle(fontSize: 15)),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                SizedBox(height: 18),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupScreen()),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Pas de compte ? ',
                      style: TextStyle(color: Colors.teal.shade800),
                      children: [
                        TextSpan(
                          text: 'Inscrivez-vous',
                          style: TextStyle(
                            color: Colors.teal.shade900,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
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
