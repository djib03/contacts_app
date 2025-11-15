import 'package:contacts_app/drawer.dart';
import 'package:contacts_app/view/home/contact/contact_create_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widget/contact_tile.dart';
import 'package:contacts_app/controller/contact_fake_data.dart';
import 'package:contacts_app/controller/theme_controller.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage({super.key});

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  final ScrollController _scrollController = ScrollController();
  bool _showFab = true;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  ContactFilter _currentFilter = ContactFilter.all;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    if (_scrollController.position.pixels > 100 && _showFab) {
      setState(() => _showFab = false);
    } else if (_scrollController.position.pixels <= 100 && !_showFab) {
      setState(() => _showFab = true);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<int> _getFilteredContactIndices(ContactModel contactModel) {
    List<int> indices = [];
    for (int i = 0; i < contactModel.contacts.length; i++) {
      final contact = contactModel.contacts[i];

      // Filtre par recherche
      if (_searchQuery.isNotEmpty) {
        if (!contact.name.toLowerCase().contains(_searchQuery.toLowerCase()) &&
            !contact.email.toLowerCase().contains(_searchQuery.toLowerCase())) {
          continue;
        }
      }

      // Filtre par type
      if (_currentFilter == ContactFilter.favorites && !contact.isFavorite) {
        continue;
      }

      indices.add(i);
    }
    return indices;
  }

  @override
  Widget build(BuildContext context) {
    final contactModel = Provider.of<ContactModel>(context);
    final themeModel = Provider.of<ThemeModel>(context);

    // Séparer favoris et autres
    final favoriteIndices = <int>[];
    final regularIndices = <int>[];

    final filteredIndices = _getFilteredContactIndices(contactModel);

    for (var index in filteredIndices) {
      if (contactModel.contacts[index].isFavorite) {
        favoriteIndices.add(index);
      } else {
        regularIndices.add(index);
      }
    }

    final hasContacts = contactModel.contacts.isNotEmpty;
    final hasFilteredResults = filteredIndices.isNotEmpty;

    return Scaffold(
      backgroundColor:
          themeModel.isDark ? Colors.grey.shade900 : Colors.grey.shade50,

      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor:
            themeModel.isDark ? Colors.grey.shade900 : Colors.grey.shade50,
        leading: Builder(
          builder:
              (context) => IconButton(
                icon: Icon(
                  Icons.menu_rounded,
                  color:
                      themeModel.isDark
                          ? Colors.grey.shade300
                          : Colors.grey.shade800,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
                splashRadius: 24,
              ),
        ),
        title:
            _isSearching
                ? SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: TextField(
                    controller: _searchController,
                    autofocus: true,
                    style: TextStyle(
                      fontSize: 14,
                      color:
                          themeModel.isDark
                              ? Colors.white
                              : Colors.grey.shade900,
                    ),
                    decoration: InputDecoration(
                      // isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 1,
                        horizontal: 9,
                      ),
                      hintText: 'Rechercher un contact...',
                      hintStyle: TextStyle(
                        color:
                            themeModel.isDark
                                ? Colors.grey.shade500
                                : Colors.grey.shade400,
                      ),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setState(() => _searchQuery = value);
                    },
                  ),
                )
                : Text(
                  "Mes contacts",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                    color:
                        themeModel.isDark ? Colors.white : Colors.grey.shade900,
                  ),
                ),
        centerTitle: false,
        actions: [
          if (_isSearching)
            IconButton(
              icon: Icon(
                Icons.close_rounded,
                color:
                    themeModel.isDark
                        ? Colors.grey.shade300
                        : Colors.grey.shade800,
              ),
              onPressed: () {
                setState(() {
                  _isSearching = false;
                  _searchQuery = '';
                  _searchController.clear();
                });
              },
              splashRadius: 24,
            )
          else
            IconButton(
              icon: Icon(
                Icons.search_rounded,
                color:
                    themeModel.isDark
                        ? Colors.grey.shade300
                        : Colors.grey.shade800,
              ),
              onPressed: () {
                setState(() => _isSearching = true);
              },
              splashRadius: 24,
            ),
        ],
      ),

      drawer: ModernDrawer(
        onThemeChanged: (bool isDark) {
          Provider.of<ThemeModel>(context, listen: false).toggle();
        },
        isDarkMode: themeModel.isDark,
        currentPage: 'contacts',
        onPageSelected: (page) {},

      ),
      body:
          !hasContacts
              ? _buildEmptyState(themeModel)
              : Column(
                children: [
                  // Filtres
                  _buildFilterChips(themeModel),
                  // Liste
                  Expanded(
                    child:
                        !hasFilteredResults
                            ? _buildNoResultsState(themeModel)
                            : RefreshIndicator(
                              onRefresh: () async {
                                await Future.delayed(
                                  const Duration(milliseconds: 500),
                                );
                                setState(() {});
                              },
                              color: Colors.teal.shade500,
                              child: ListView.builder(
                                controller: _scrollController,
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 100,
                                ),
                                itemCount: _buildItemCount(
                                  favoriteIndices,
                                  regularIndices,
                                ),
                                itemBuilder: (context, index) {
                                  return _buildListItem(
                                    context,
                                    index,
                                    favoriteIndices,
                                    regularIndices,
                                    contactModel,
                                    themeModel,
                                  );
                                },
                              ),
                            ),
                  ),
                ],
              ),

      floatingActionButton: AnimatedScale(
        scale: _showFab ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: FloatingActionButton.extended(
          backgroundColor: Colors.teal.shade500,
          foregroundColor: Colors.white,
          elevation: 2,
          highlightElevation: 4,
          onPressed: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder:
                    (context, animation, secondaryAnimation) =>
                        ContactCreatePage(),
                transitionsBuilder: (
                  context,
                  animation,
                  secondaryAnimation,
                  child,
                ) {
                  const begin = Offset(0.0, 1.0);
                  const end = Offset.zero;
                  const curve = Curves.easeInOutCubic;
                  var tween = Tween(
                    begin: begin,
                    end: end,
                  ).chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);
                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
                transitionDuration: const Duration(milliseconds: 300),
              ),
            );
          },
          icon: const Icon(Icons.person_add_rounded, size: 22),
          label: const Text(
            'Nouveau',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips(ThemeModel themeModel) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          _buildFilterChip(
            label: 'Tous',
            isSelected: _currentFilter == ContactFilter.all,
            onTap: () => setState(() => _currentFilter = ContactFilter.all),
            themeModel: themeModel,
          ),
          const SizedBox(width: 8),
          _buildFilterChip(
            label: 'Favoris',
            icon: Icons.star_rounded,
            isSelected: _currentFilter == ContactFilter.favorites,
            onTap:
                () => setState(() => _currentFilter = ContactFilter.favorites),
            themeModel: themeModel,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    IconData? icon,
    required bool isSelected,
    required VoidCallback onTap,
    required ThemeModel themeModel,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? Colors.teal.shade500
                  : themeModel.isDark
                  ? Colors.grey.shade800
                  : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:
                isSelected
                    ? Colors.teal.shade500
                    : themeModel.isDark
                    ? Colors.grey.shade700
                    : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 16,
                color:
                    isSelected
                        ? Colors.white
                        : themeModel.isDark
                        ? Colors.grey.shade400
                        : Colors.grey.shade600,
              ),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color:
                    isSelected
                        ? Colors.white
                        : themeModel.isDark
                        ? Colors.grey.shade300
                        : Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _buildItemCount(List<int> favoriteIndices, List<int> regularIndices) {
    int count = 0;

    if (favoriteIndices.isNotEmpty) {
      count += 1; // Header "Favoris"
      count += favoriteIndices.length;
    }

    if (regularIndices.isNotEmpty) {
      count += 1; // Header "Autres contacts"
      count += regularIndices.length;
    }

    return count;
  }

  Widget _buildListItem(
    BuildContext context,
    int index,
    List<int> favoriteIndices,
    List<int> regularIndices,
    ContactModel contactModel,
    ThemeModel themeModel,
  ) {
    int currentIndex = 0;

    // Section Favoris
    if (favoriteIndices.isNotEmpty) {
      if (index == currentIndex) {
        return _buildSectionHeader('Favoris', themeModel);
      }
      currentIndex++;

      if (index < currentIndex + favoriteIndices.length) {
        final contactIndex = favoriteIndices[index - currentIndex];
        return ContactTile(
          contacts: contactModel.contacts[contactIndex],
          contactIndex: contactIndex,
          onFavoritePresssed: () {
            contactModel.changeFavoriteStatus(contactIndex);
          },
        );
      }
      currentIndex += favoriteIndices.length;
    }

    // Section Autres
    if (regularIndices.isNotEmpty) {
      if (index == currentIndex) {
        return _buildSectionHeader('Autres contacts', themeModel);
      }
      currentIndex++;

      final contactIndex = regularIndices[index - currentIndex];
      return ContactTile(
        contacts: contactModel.contacts[contactIndex],
        contactIndex: contactIndex,
        onFavoritePresssed: () {
          contactModel.changeFavoriteStatus(contactIndex);
        },
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildSectionHeader(String title, ThemeModel themeModel) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
          color:
              themeModel.isDark ? Colors.grey.shade500 : Colors.grey.shade600,
        ),
      ),
    );
  }

  Widget _buildEmptyState(ThemeModel themeModel) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  themeModel.isDark
                      ? Colors.grey.shade800
                      : Colors.teal.shade50,
            ),
            child: Icon(
              Icons.contacts_rounded,
              size: 64,
              color:
                  themeModel.isDark
                      ? Colors.teal.shade400
                      : Colors.teal.shade300,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Aucun contact',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color:
                  themeModel.isDark
                      ? Colors.grey.shade300
                      : Colors.grey.shade800,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Appuyez sur + pour ajouter\nvotre premier contact',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color:
                  themeModel.isDark
                      ? Colors.grey.shade500
                      : Colors.grey.shade600,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResultsState(ThemeModel themeModel) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 64,
            color:
                themeModel.isDark ? Colors.grey.shade700 : Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'Aucun résultat',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color:
                  themeModel.isDark
                      ? Colors.grey.shade400
                      : Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Essayez avec un autre terme',
            style: TextStyle(
              fontSize: 14,
              color:
                  themeModel.isDark
                      ? Colors.grey.shade600
                      : Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}

enum ContactFilter { all, favorites }
