import 'package:cinemapedia/presentation/views/views.dart';
import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  static const name = 'home_screen';
  final int pageIndex;
  const HomeScreen({super.key, required this.pageIndex});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(keepPage: true);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final viewRoutes = const <Widget>[
    HomeView(),
    PopularView(), // CategoriasView
    FavoritesView(),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (pageController.hasClients) {
      pageController.animateToPage(widget.pageIndex,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }

    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        //index: pageIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: widget.pageIndex,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
