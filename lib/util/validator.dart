class Validators {
  //validators either return null or error message
  //if the value is not valid, return an error message
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email obligatoire';
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) return 'Email invalide';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Mot de passe obligatoire';
    if (value.length < 6) return 'Au moins 6 caractères';
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Numéro obligatoire';
    if (value.length < 8) return 'Numéro invalide';
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Le nom est requis';
    }
    return null;
  }
}
