import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:meals_app/widgets/filter_switch.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final activeFilter = ref.watch(filterProvider);

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
        canPop: true,
        child: Column(
          children: [
            FilterSwitch(
              text: 'Gluten-free',
              subtitle: 'Only include gluten-free meals.',
              value: activeFilter[EFilter.glutenFree]!,
              onChanged: (isChecked) {
                ref
                    .read(filterProvider.notifier)
                    .toggleFilter(EFilter.glutenFree, isChecked);
              },
            ),
            FilterSwitch(
              text: 'Lactose-free',
              subtitle: 'Only include lactose-free meals.',
              value: activeFilter[EFilter.lactoseFree]!,
              onChanged: (isChecked) {
                ref
                    .read(filterProvider.notifier)
                    .toggleFilter(EFilter.lactoseFree, isChecked);
              },
            ),
            FilterSwitch(
              text: 'Vegetarian',
              subtitle: 'Only include vegetarian meals.',
              value: activeFilter[EFilter.vegetarian]!,
              onChanged: (isChecked) {
                ref
                    .read(filterProvider.notifier)
                    .toggleFilter(EFilter.vegetarian, isChecked);
              },
            ),
            FilterSwitch(
              text: 'Vegan',
              subtitle: 'Only include vegan meals.',
              value: activeFilter[EFilter.vegan]!,
              onChanged: (isChecked) {
                ref
                    .read(filterProvider.notifier)
                    .toggleFilter(EFilter.vegan, isChecked);
              },
            ),
          ],
        ),
      ),
    );
  }
}
