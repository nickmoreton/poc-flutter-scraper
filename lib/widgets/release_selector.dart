import 'package:flutter/material.dart';
import '../config.dart';

class ReleaseSelector extends StatelessWidget {
  final String? selectedRelease;
  final ValueChanged<String?> onReleaseSelected;

  const ReleaseSelector({
    Key? key,
    this.selectedRelease,
    required this.onReleaseSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: wagtailReleases.entries.map((release) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ChoiceChip(
                label: Text(release.value),
                selected: selectedRelease == release.key,
                onSelected: (bool selected) {
                  onReleaseSelected(selected ? release.key : null);
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
