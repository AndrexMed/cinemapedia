import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home_screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    // final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideShowProvider);

    return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        centerTitle: false,
        flexibleSpace: FlexibleSpaceBar(
          title: SizedBox(
            width: double.infinity,
            child: CustomAppbar(),
          ),
        ),
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Column(
            children: [
              //const CustomAppbar(),

              MoviesSlideshow(movies: slideShowMovies),

              MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  title: 'En Cines',
                  subtitle: '20',
                  loadNextPage: () => ref
                      .read(nowPlayingMoviesProvider.notifier)
                      .loadNextPage()),

              MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  title: 'Populares',
                  subtitle: '20',
                  loadNextPage: () => ref
                      .read(nowPlayingMoviesProvider.notifier)
                      .loadNextPage()),

              const SizedBox(height: 50),
            ],
          );
        },
        childCount: 1,
      ))
    ]);
  }
}
