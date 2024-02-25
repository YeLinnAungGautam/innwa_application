import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/screen/filter/filter.dart';

class FilterDrawer extends StatelessWidget {
  const FilterDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 60.0),
      child: FilterBy(),
    );
  }
}