import 'package:cinemapedia/domain/repositories/local_storage_repository.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

final favoriteMoviesProvider =
    StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>((ref) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return StorageMoviesNotifier(localStorageRepository: localStorageRepository);
});

/*
  {
    1234: Movie,
    1645: Movie,
    6523: Movie,
  }

*/

class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;
  final LocalStorageRepository localStorageRepository;

  StorageMoviesNotifier({required this.localStorageRepository}) : super({});

  Future<List<Movie>> loadNextPage() async {
    final movies = await localStorageRepository.loadFavoritesMovies(
        offset: page * 10, limit: 20);
    page++;

    final tempMoviesMap = <int, Movie>{};
    for (final movie in movies) {
      tempMoviesMap[movie.id] = movie;
    }

    state = {...state, ...tempMoviesMap};

    return movies;
  }

  Future<void> toggleFavorite(Movie movie) async {
    await localStorageRepository.toggleFavorite(movie);
    final bool isMovieInFavorites = state[movie.id] != null;

    if (isMovieInFavorites) {
      state.remove(movie.id);
      state = {...state};
    } else {
      state = {...state, movie.id: movie};
    }
  }
}


//Forma vista en los comentarios en caso de presentar problema en movil.
// import 'package:cinemapedia/domain/entities/movie.dart';
// import 'package:cinemapedia/domain/repositories/local_storage_repository.dart';
// import 'package:cinemapedia/presentation/providers/providers.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final isFavoriteProvider =
//     StateNotifierProvider.family<FavoriteNotifier, bool, int>((ref, movieId) {
//   final localStorageRepository = ref.watch(localStorageRepositoryProvider);

//   return FavoriteNotifier(localStorageRepository, movieId);
// });

// class FavoriteNotifier extends StateNotifier<bool> {
//   final LocalStorageRepository localStorageRepository;
//   final int movieId;

//   FavoriteNotifier(
//     this.localStorageRepository,
//     this.movieId,
//   ) : super(false) {
//     _loadFavoriteStatus();
//   }

//   Future<void> _loadFavoriteStatus() async {
//     final isFavorite = await localStorageRepository.isMovieFavorite(movieId);
//     state = isFavorite;
//   }

//   Future<void> toggleFavorite(Movie movie) async {
//     await localStorageRepository.toggleFavorite(movie);

//     state = !state;
//   }
// }
