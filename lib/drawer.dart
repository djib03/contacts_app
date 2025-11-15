import 'package:flutter/material.dart';

class ModernDrawer extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;
  final String currentPage;
  final Function(String) onPageSelected;

  const ModernDrawer({
    super.key,
    required this.onThemeChanged,
    required this.isDarkMode,
    required this.currentPage,
    required this.onPageSelected,
  });

  @override
  State<ModernDrawer> createState() => _ModernDrawerState();
}

class _ModernDrawerState extends State<ModernDrawer> {
  String selectedItem = 'contacts';

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;
    // final theme = Theme.of(context);

    return Drawer(
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      child: Column(
        children: [
          // En-tête du drawer
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors:
                isDark
                    ? [Colors.teal.shade900, Colors.teal.shade700]
                    : [Colors.teal, Colors.teal.shade700],
              ),
            ),
            child: Center(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
              Container(
             decoration: BoxDecoration(
               shape: BoxShape.circle,
               border: Border.all(color: Colors.white),
               color: Colors.white,
             ),
                child: CircleAvatar(
                  backgroundColor: Colors.teal,


                radius: 30,
                child: Icon(Icons.person),
                            ),
              ),
            SizedBox(height: 10),
            Text(
                'Nom de l\'utilisateur',
            style: TextStyle(color: Colors.white, fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
    ),

    // Menu items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _buildMenuItem(
                  context,
                  icon: Icons.contacts_rounded,
                  title: 'Tous les contacts',
                  value: 'contacts',
                  isDark: isDark,
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.favorite_rounded,
                  title: 'Favoris',
                  value: 'favorites',
                  isDark: isDark,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Divider(height: 1),
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.person_rounded,
                  title: 'Profil',
                  value: 'profile',
                  isDark: isDark,
                ),
              ],
            ),
          ),

          // Section inférieure avec mode sombre et déconnexion
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF5F5F5),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                // Toggle mode sombre
                Container(
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    leading: Icon(
                      isDark
                          ? Icons.dark_mode_rounded
                          : Icons.light_mode_rounded,
                      color: isDark ? const Color(0xFF64FFDA) : Colors.teal,
                    ),
                    title: Text(
                      'Mode sombre',
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black87,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Switch(
                      value: widget.isDarkMode,
                      onChanged: widget.onThemeChanged,
                      activeColor: const Color(0xFF64FFDA),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Bouton déconnexion
                Container(
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    leading: Icon(Icons.logout_rounded, color: Colors.red[400]),
                    title: Text(
                      'Déconnexion',
                      style: TextStyle(
                        color: Colors.red[400],
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      _showLogoutDialog(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required bool isDark,
  }) {
    final isSelected = widget.currentPage == value;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Container(
        decoration: BoxDecoration(

          color:
              isSelected
                  ? (isDark
                      ? const Color(0xFF64FFDA).withOpacity(0.15)
                      : Colors.teal.withOpacity(0.1))
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          leading: Icon(
            icon,
            color:
                isSelected
                    ? (isDark ? const Color(0xFF64FFDA) : Colors.teal)
                    : (isDark ? Colors.white70 : Colors.grey[700]),
            size: 24,
          ),
          title: Text(
            title,
            style: TextStyle(
              color:
                  isSelected
                      ? (isDark ? const Color(0xFF64FFDA) : Colors.teal)
                      : (isDark ? Colors.white : Colors.black87),
              fontSize: 15,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
          onTap: () {
            setState(() {
              selectedItem = value;
            });
            Navigator.pop(context);
            // Ajoutez votre navigation ici
            _navigateToPage(value);
          },
        ),
      ),
    );
  }

// dart
  void _navigateToPage(String page) {
    final route = (page == 'favorites') ? '/favorites' :
    (page == 'profile')   ? '/profile'   : '/contacts';

    if (page == 'contacts') {
      // Pour la page contacts, vider la pile et la mettre comme seule base
      Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
    } else {
      // Pour les autres pages, garder contacts en dessous
      Navigator.pushReplacementNamed(context, route);
    }
  }


  void _showLogoutDialog(BuildContext context) {
    final isDark = widget.isDarkMode;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDark ? const Color(0xFF2A2A2A) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Déconnexion',
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Êtes-vous sûr de vouloir vous déconnecter ?',
            style: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Annuler',
                style: TextStyle(
                  color: isDark ? Colors.white70 : Colors.grey[600],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Ajoutez votre logique de déconnexion ici
                // Par exemple : context.read<AuthProvider>().logout();
                print('Déconnexion...');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[400],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Déconnexion'),
            ),
          ],
        );
      },
    );
  }
}
