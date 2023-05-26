import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  const CustomBottomNavigationBar({super.key, required this.currentIndex});

  // int getCurrentIndex(BuildContext context) {
  //   final String location = GoRouterState.of(context).location;

  //   switch (location) {
  //     case '/':
  //       return 0;

  //     case '/categories':
  //       return 1;

  //     case '/favorites':
  //       return 2;

  //     default:
  //       return 0;
  //   }
  // }

  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home/$index');
        break;
      case 1:
        context.go('/home/$index');
        break;
      case 2:
        context.go('/home/$index');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: colors.primary,
      onTap: (value) => onItemTapped(context, value),
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_max),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info_outline_rounded),
          label: 'Info',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: 'Favorites',
        ),
      ],
    );
  }
}
