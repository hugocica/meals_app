import 'package:flutter/material.dart';
import 'package:meals_app/widgets/filter_switch.dart';

enum EFilter { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.activeFilters});

  final Map<EFilter, bool> activeFilters;

  @override
  State<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFreeFilterSet = false;
  bool _lactoseFreeFilterSet = false;
  bool _vegetarianFilterSet = false;
  bool _veganFilterSet = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      _glutenFreeFilterSet = widget.activeFilters[EFilter.glutenFree]!;
      _lactoseFreeFilterSet = widget.activeFilters[EFilter.lactoseFree]!;
      _vegetarianFilterSet = widget.activeFilters[EFilter.vegetarian]!;
      _veganFilterSet = widget.activeFilters[EFilter.vegan]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // drawer: MainDrawer(
      //   onSelectScreen: (String id) {
      //     Navigator.of(context).pop();
      //
      //     if (id == 'meals') {
      //       Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(
      //           builder: (ctx) => const TabsScreen(),
      //         ),
      //       );
      //     }
      //   },
      // ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) {
            return;
          }

          Navigator.of(context).pop({
            EFilter.glutenFree: _glutenFreeFilterSet,
            EFilter.lactoseFree: _lactoseFreeFilterSet,
            EFilter.vegetarian: _vegetarianFilterSet,
            EFilter.vegan: _veganFilterSet,
          });
        },
        child: Column(
          children: [
            FilterSwitch(
              text: 'Gluten-free',
              subtitle: 'Only include gluten-free meals.',
              value: _glutenFreeFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _glutenFreeFilterSet = isChecked;
                });
              },
            ),
            FilterSwitch(
              text: 'Lactose-free',
              subtitle: 'Only include lactose-free meals.',
              value: _lactoseFreeFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _lactoseFreeFilterSet = isChecked;
                });
              },
            ),
            FilterSwitch(
              text: 'Vegetarian',
              subtitle: 'Only include vegetarian meals.',
              value: _vegetarianFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _vegetarianFilterSet = isChecked;
                });
              },
            ),
            FilterSwitch(
              text: 'Vegan',
              subtitle: 'Only include vegan meals.',
              value: _veganFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _veganFilterSet = isChecked;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
