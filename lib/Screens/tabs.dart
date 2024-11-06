import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/Screens/categories.dart';
import 'package:meals/Screens/filters.dart';
import 'package:meals/Screens/meals.dart';
import 'package:meals/Screens/settings.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/providers/filters_provider.dart';
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
  // _showFavMessage(String message) {
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   ScaffoldMessenger.of(context).clearMaterialBanners();
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(message),
  //       duration: const Duration(seconds: 2),
  //     ),
  //   );
  //   ScaffoldMessenger.of(context).showMaterialBanner(
  //     MaterialBanner(
  //       content: Text(message),
  //       actions: [
  //         TextButton(
  //             onPressed:
  //                 ScaffoldMessenger.of(context).hideCurrentMaterialBanner,
  //             child: const Text('Close'))
  //       ],
  //     ),
  //   );
  // }

  _selectPage(int value) {
    setState(() {
      _selectedindex = value;
    });
  }

  _setScreen(String identifier) async {
    Navigator.pop(context); // Close the drawer
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
    // else {
    //   Navigator.of(context).pop();
    // }
  }

  @override
  Widget build(BuildContext context) {
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
      drawer:
          //Drawer(
          //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          // ),
          MainDrawer(selectScreen: _setScreen),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        elevation: 2,
        title: Text(
          activePageTitle,
        ),
      ),
      body: activePage,
      bottomNavigationBar: CurvedNavigationBar(
        color: Theme.of(context).canvasColor,
        backgroundColor: Theme.of(context).primaryColor,
        items: const [
          CurvedNavigationBarItem(
            child: Icon(Icons.home),
            label: 'Home',
          ),
          CurvedNavigationBarItem(child: Icon(Icons.star), label: 'Favorites')
        ],
        onTap: (value) {
          _selectPage(value);
        },
        index: _selectedindex,
        buttonBackgroundColor: Theme.of(context).secondaryHeaderColor,
        height: 60,
        animationCurve: Easing.legacy,
        //iconPadding: BouncingScrollSimulation.maxSpringTransferVelocity,
      ),
    );
  }
}
