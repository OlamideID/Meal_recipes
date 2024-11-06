import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meals/providers/meal_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier() : super({
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegan: false,
    Filter.vegetarian: false,
  }) {
    _loadFilters(); // Load filters on initialization
  }

  // Load filter settings from SharedPreferences
  Future<void> _loadFilters() async {
    final prefs = await SharedPreferences.getInstance();
    state = {
      Filter.glutenFree: prefs.getBool('glutenFree') ?? false,
      Filter.lactoseFree: prefs.getBool('lactoseFree') ?? false,
      Filter.vegan: prefs.getBool('vegan') ?? false,
      Filter.vegetarian: prefs.getBool('vegetarian') ?? false,
    };
  }

  // Save filter settings to SharedPreferences
  Future<void> _saveFilters() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('glutenFree', state[Filter.glutenFree]!);
    prefs.setBool('lactoseFree', state[Filter.lactoseFree]!);
    prefs.setBool('vegan', state[Filter.vegan]!);
    prefs.setBool('vegetarian', state[Filter.vegetarian]!);
  }

  // Update all filters and save
  setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
    _saveFilters(); // Save updated filters
  }

  // Update a single filter and save
  setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
    _saveFilters(); // Save updated filter state
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
  (ref) => FiltersNotifier(),
);

final filteredMeals = Provider(
  (ref) {
    final meals = ref.watch(mealsProvider);
    final selectedFilters = ref.watch(filtersProvider);
    return meals.where((meal) {
      if (selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      if (selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();
  },
);
