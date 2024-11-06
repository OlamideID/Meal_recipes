import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/meal_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteNotifier extends StateNotifier<List<Meal>> {
  FavoriteNotifier(this.ref) : super([]) {
    _loadFavorites();
  }

  final Ref ref;
  static const _favoritesKey = 'favoriteMeals';

  /// Toggle meal in favorites and save to SharedPreferences.
  bool toggleMealFav(Meal meal) {
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
    } else {
      state = [...state, meal];
    }

    _saveFavorites();
    return !mealIsFavorite;
  }

  /// Load favorite meals from SharedPreferences.
  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final savedIds = prefs.getStringList(_favoritesKey) ?? [];

    // Reference the complete list of meals using mealsProvider
    final allMeals = ref.read(mealsProvider);
    state = allMeals.where((meal) => savedIds.contains(meal.id)).toList();
  }

  /// Save current favorite meals to SharedPreferences.
  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final mealIds = state.map((meal) => meal.id).toList();
    await prefs.setStringList(_favoritesKey, mealIds);
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteNotifier, List<Meal>>((ref) {
  return FavoriteNotifier(ref);
});
