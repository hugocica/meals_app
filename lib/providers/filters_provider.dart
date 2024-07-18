import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        (ref) => FiltersNotifier());
