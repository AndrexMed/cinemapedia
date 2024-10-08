import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/configs/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMoviesCallback;
  List<Movie> initialMovies;
  StreamController<List<Movie>> debouncer = StreamController.broadcast();
  StreamController<bool> isLoading = StreamController.broadcast();
  Timer? _debounceTimer;
  SearchMovieDelegate(
      {required this.searchMoviesCallback, required this.initialMovies});

  void clearStreams() {
    debouncer.close();
  }

  void _onQueryChanged(String query) {
    isLoading.add(true);
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      // if (query.isEmpty) {
      //   debouncer.add([]);
      //   return;
      // }
      final movies = await searchMoviesCallback(query);
      initialMovies = movies;
      debouncer.add(movies);

      isLoading.add(false);
    });
  }

  @override
  String get searchFieldLabel => 'Buscar Película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder<bool>(
          initialData: false,
          stream: isLoading.stream,
          builder: (context, snapshot) {
            if (snapshot.data ?? false) {
              return SpinPerfect(
                duration: const Duration(seconds: 20),
                spins: 10,
                infinite: true,
                child: IconButton(
                    onPressed: () => query = '',
                    icon: const Icon(Icons.refresh_rounded)),
              );
            }

            return FadeIn(
              animate: query.isNotEmpty,
              child: IconButton(
                  onPressed: () => query = '', icon: const Icon(Icons.clear)),
            );
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          clearStreams();
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  Widget buildResultsAndSuggestions(BuildContext context) {
    return StreamBuilder<List<Movie>>(
        initialData: initialMovies,
        stream: debouncer.stream,
        builder: (context, snapshot) {
          final movies = snapshot.data ?? [];

          if (movies.isEmpty) {
            return const Center(child: Text('No se encontraron películas.'));
          }

          return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return _MovieItem(
                    movie: movie,
                    onMovieSelected: (context, movie) {
                      clearStreams();
                      close(context, movie);
                    });
              });
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return buildResultsAndSuggestions(context);
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;
  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => onMovieSelected(context, movie),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(children: [
          //Image
          SizedBox(
            width: size.width * 0.2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath!,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return FadeIn(child: child);
                },
              ),
            ),
          ),

          const SizedBox(width: 10),
          //Descripcion

          SizedBox(
            width: size.width * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: textTheme.titleMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  movie.overview,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),

                //Rating
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: colors.primary,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      HumanFormats.formatNumber(movie.voteAverage, 1),
                      style: textTheme.bodyMedium,
                    ),
                  ],
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
