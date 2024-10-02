import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView();

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upComingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);

    if (initialLoading) {
      return const FullScreenLoader();
    }

    // final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideShowProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upComingMovies = ref.watch(upComingMoviesProvider);

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
                  movies: popularMovies,
                  title: 'Populares',
                  subtitle: '20',
                  loadNextPage: () =>
                      ref.read(popularMoviesProvider.notifier).loadNextPage()),

              MovieHorizontalListview(
                  movies: topRatedMovies,
                  title: 'Top Rated',
                  subtitle: '20',
                  loadNextPage: () =>
                      ref.read(topRatedMoviesProvider.notifier).loadNextPage()),

              MovieHorizontalListview(
                  movies: upComingMovies,
                  title: 'Upcoming',
                  subtitle: '20',
                  loadNextPage: () =>
                      ref.read(upComingMoviesProvider.notifier).loadNextPage()),

              const SizedBox(height: 50),
            ],
          );
        },
        childCount: 1,
      ))
    ]);
  }
}
