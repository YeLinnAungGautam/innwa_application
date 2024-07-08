import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:innwa_mobile_dev/util/constants.dart";


/// Builds the "shell" for the app by building a Scaffold with a
/// BottomNavigationBar, where child is placed in the body of the Scaffold.
class HomeScreenNavBar extends StatelessWidget {
  /// Constructs an [HomeScreenNavBar].
  HomeScreenNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>("HomeScreenNavBar"));

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _clickBottomBar({required int index}) {
    // When navigating to a new branch, it's recommended to use the goBranch
    // method, as doing so makes sure the last navigation state of the
    // Navigator for the branch is restored.
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
          currentFocus.unfocus();
        }
      },
      child: Container(
        color: backgroundColorLight,
        child: SafeArea(
          child: Scaffold(
            key: _scaffoldKey,
            resizeToAvoidBottomInset: false,
           
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: backgroundColorLight,
              selectedFontSize: 10.0,
              unselectedFontSize: 10.0,
              currentIndex: navigationShell.currentIndex,
              elevation: 0.0,
              selectedItemColor: selectedItemColor,
              unselectedItemColor: unSelectedItemColor,
              selectedLabelStyle: const TextStyle(color: selectedItemColor),
              unselectedLabelStyle: const TextStyle(color: unSelectedItemColor),
              showUnselectedLabels: true,
              onTap: (index) {
                _clickBottomBar(index: index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.discount),
                  label: 'Promotion',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: 'Products',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.lightbulb_outlined),
                  label: 'Articles',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.info),
                  label: 'About',
                ),
              ],
            ),
            body: navigationShell,
          ),
        ),
      ),
    );
  }
}
