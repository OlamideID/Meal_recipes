import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:meals/Screens/categories.dart';
import 'package:meals/Screens/filters.dart';
import 'package:meals/Screens/meals.dart';
import 'package:meals/Screens/settings.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/providers/theme_provider.dart';
import 'package:meals/widgets/main_drawer.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
  Filter.lactoseFree: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedindex = 0;

  void _selectPage(int value) {
    setState(() {
      _selectedindex = value;
    });
  }

  Future<void> _setScreen(String identifier) async {
    Navigator.pop(context); 
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (context) => const FiltersScreen(),
        ),
      );
    } else if (identifier == 'settings') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const SettingsScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
  final isDark = ref.watch(themeNotifierProvider) == ThemeMode.dark;

    final availableMeals = ref.watch(filteredMeals);

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedindex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
      );
      activePageTitle = 'Favorites';
    }

    return Scaffold(
      drawer: MainDrawer(selectScreen: _setScreen),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        elevation: 2,
        title: Text(
          activePageTitle,
        ),
      ),
      body: activePage,
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: kIsWeb
              ? GNav(
                  selectedIndex: _selectedindex,
                  onTabChange: _selectPage,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  gap: 10,
                  textStyle: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  color: Colors.grey[600], // Inactive color
                  activeColor: Theme.of(context).primaryColor,
                  tabBackgroundColor:
                      Theme.of(context).primaryColor.withOpacity(0.1),
                  tabs: [
                    GButton(
                      icon: Icons.home,
                      text: 'Home',
                      iconActiveColor: Colors.amberAccent,
                      iconColor: isDark ? Colors.white : Colors.black,
                    ),
                    GButton(
                      icon: Icons.favorite,
                      text: 'Favorites',
                      iconActiveColor: Colors.pink,
                      iconColor: isDark ? Colors.white : Colors.black,
                    ),
                  ],
                )
              : CurvedNavigationBar(
                  color: Theme.of(context).canvasColor,
                  backgroundColor: Colors.transparent,
                  items: const [
                    CurvedNavigationBarItem(
                      child: Icon(
                        Icons.home,
                        color: Colors.amberAccent,
                      ),
                      label: 'Home',
                    ),
                    CurvedNavigationBarItem(
                      child: Icon(
                        Icons.favorite,
                        color: Colors.pink,
                      ),
                      label: 'Favorites',
                    ),
                  ],
                  onTap: _selectPage,
                  index: _selectedindex,
                  height: 60,
                  animationCurve: Curves.easeInOut,
                ),
        ),
      ),
    );
  }
}
