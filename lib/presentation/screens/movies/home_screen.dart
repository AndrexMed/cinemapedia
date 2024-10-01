import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home_screen';

  //final Widget childView;

  // En lugar de recibir el Widget childView, reemplazamos por el shell de navegación,
  // el cual, es un contenedor de las ramas que definimos en el router.
  final StatefulNavigationShell navigationShell;

  const HomeScreen(
      {super.key,
      //required this.childView,
      required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: CustomBottomNavigation(
        navigationShell: navigationShell,
      ),
    );
  }
}
