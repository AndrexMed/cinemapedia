import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_by_movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie_screen';
  final String movieId;
  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }
    return Scaffold(
        body: CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        _MovieSliverAppBar(movie: movie),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => _MovieOverview(movie: movie),
            childCount: 1,
          ),
        )
      ],
    ));
  }
}

class _MovieSliverAppBar extends StatelessWidget {
  final Movie movie;
  const _MovieSliverAppBar({required this.movie});
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
        backgroundColor: Colors.black,
        expandedHeight: size.height * 0.7,
        foregroundColor: Colors.white,
        // floating: false,
        // pinned: true,
        flexibleSpace: FlexibleSpaceBar(
            titlePadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            title: Text(
              movie.title,
              style: textTheme.titleMedium,
              textAlign: TextAlign.start,
            ),
            background: Stack(
              children: [
                SizedBox.expand(
                  child: Image.network(
                    movie.posterPath,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress != null) {
                        return const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        );
                      }
                      return child;
                    },
                  ),
                ),
                const SizedBox.expand(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                )
              ],
            )));
  }
}

class _MovieOverview extends StatelessWidget {
  final Movie movie;
  const _MovieOverview({required this.movie});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    movie.posterPath,
                    width: size.width * 0.3,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress != null) {
                        return const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        );
                      }
                      return child;
                    },
                  ),
                ),
                const SizedBox(width: 10),

                //Descripcion
                SizedBox(
                  width: (size.width - 40) * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(movie.title, style: textTheme.titleLarge),
                      const SizedBox(height: 5),
                      Text(
                        movie.overview,
                        style: textTheme.labelSmall,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          //Generos de la pelicula
          Padding(
              padding: const EdgeInsets.all(8),
              child: Wrap(
                children: [
                  ...movie.genreIds.map((genre) => Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: Chip(
                          label: Text(genre),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      )),
                ],
              )),

          const SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
