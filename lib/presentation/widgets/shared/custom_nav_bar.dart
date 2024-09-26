import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        //elevation: 0, para ocultar linea separadora sobre el menu.
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Categorias'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explorar'),
        ]);
  }
}
