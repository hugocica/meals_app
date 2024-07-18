import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meals_provider.dart';

enum EFilter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

const kInitialFilters = {
  EFilter.glutenFree: false,
  EFilter.lactoseFree: false,
  EFilter.vegetarian: false,
  EFilter.vegan: false,
};

class FiltersNotifier extends StateNotifier<Map<EFilter, bool>> {
  FiltersNotifier() : super(kInitialFilters);

  void toggleFilter(EFilter filter, bool status) {
    state = {...state, filter: status};
  }
}

final filterProvider =
    StateNotifierProvider<FiltersNotifier, Map<EFilter, bool>>(
  (ref) => FiltersNotifier(),
);

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filterProvider);

  return meals
      .where((meal) =>
          !((activeFilters[EFilter.glutenFree]! && !meal.isGlutenFree) ||
              (activeFilters[EFilter.lactoseFree]! && !meal.isLactoseFree) ||
              (activeFilters[EFilter.vegetarian]! && !meal.isVegetarian) ||
              (activeFilters[EFilter.vegan]! && !meal.isVegan)))
      .toList();
});
