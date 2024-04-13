import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/util/constants.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final FocusScopeNode _node = FocusScopeNode();
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _node.unfocus();
    _searchController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          // Add padding around the search bar
          // Use a Material design search bar
          child: TextField(
            autofocus: false,
            controller: _searchController,
            decoration: InputDecoration(
              filled: true,
              fillColor: searchColor,
              focusColor: searchColor,
              border: InputBorder.none,
              hintText: 'Search Products',
              prefixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () { 
                  // Perform the search here
                },
              ),
            ),
          ),
        ));
  }
}
