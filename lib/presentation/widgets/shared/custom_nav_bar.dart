import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomNavBar extends StatelessWidget {
  final int currentIndex;
  const CustomNavBar({super.key, required this.currentIndex});

  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home/0');
        break;
      case 1:
        context.go('/home/1');
        break;
      case 2:
        context.go('/home/2');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) => onItemTapped(context, value),
        //elevation: 0, para ocultar linea separadora sobre el menu.
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(
              icon: Icon(Icons.thumbs_up_down_outlined), label: 'Populares'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline), label: 'Favoritos'),
        ]);
  }
}
