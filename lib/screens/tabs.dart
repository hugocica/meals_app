import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

const kInitialFilters = {
  EFilter.glutenFree: false,
  EFilter.lactoseFree: false,
  EFilter.vegetarian: false,
  EFilter.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];
  Map<EFilter, bool> _activeFilters = kInitialFilters;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isFavorite = _favoriteMeals.contains(meal);

    if (isFavorite) {
      setState(() {
        _favoriteMeals.remove(meal);
        _showInfoMessage('Meal is no longer a favorite.');
      });
    } else {
      setState(() {
        _favoriteMeals.add(meal);
        _showInfoMessage('Meal is marked as favorite!');
      });
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String id) async {
    Navigator.of(context).pop();

    if (id == 'filters') {
      final filters = await Navigator.of(context).push<Map<EFilter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            activeFilters: _activeFilters,
          ),
        ),
      );

      setState(() {
        _activeFilters = filters ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals
        .where((meal) =>
            (_activeFilters[EFilter.glutenFree]! && meal.isGlutenFree) ||
            (_activeFilters[EFilter.lactoseFree]! && meal.isLactoseFree) ||
            (_activeFilters[EFilter.vegetarian]! && meal.isVegetarian) ||
            (_activeFilters[EFilter.vegan]! && meal.isVegan))
        .toList();

    Widget activePage = CategoriesScreen(
      favoriteMeals: _favoriteMeals,
      availableMeals: availableMeals,
      onToggleFavorite: _toggleMealFavoriteStatus,
    );
    String activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeals,
        favoriteMeals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitle = 'Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
