import 'package:flutter/material.dart';

class FilterSwitch extends StatelessWidget {
  const FilterSwitch(
      {super.key,
      required this.value,
      required this.onChanged,
      required this.text,
      required this.subtitle});

  final String text;
  final String subtitle;
  final bool value;
  final void Function(bool status) onChanged;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      title: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
    );
  }
}
