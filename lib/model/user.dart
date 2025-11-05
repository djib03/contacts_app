class User {
  final String? id; // c est l identifiant unique de l utilisateur
  final String firstname; //c est le prenom
  final String lastname; //c est le nom
  final String email; //c est l email
  final String? phoneNumber; //c est le numero de telephone
  final String password; //c est le mot de passe

  User({
    this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    this.phoneNumber,
    required this.password,
  });
}
