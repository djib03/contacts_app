import 'package:flutter/material.dart';

class ModernDrawer extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;

  const ModernDrawer({
    Key? key,
    required this.onThemeChanged,
    required this.isDarkMode,
  }) : super(key: key);

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
          Container(
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    // ignore: deprecated_member_use
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'John Doe',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'john.doe@email.com',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
              ],
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
                  title: 'Profile',
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
    final isSelected = selectedItem == value;

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

  void _navigateToPage(String page) {
    // Implémentez votre logique de navigation ici
    // Par exemple :
    // if (page == 'contacts') {
    //   Navigator.pushReplacementNamed(context, '/contacts');
    // } else if (page == 'favorites') {
    //   Navigator.pushReplacementNamed(context, '/favorites');
    // } else if (page == 'profile') {
    //   Navigator.pushReplacementNamed(context, '/profile');
    // }
    print('Navigation vers: $page');
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
