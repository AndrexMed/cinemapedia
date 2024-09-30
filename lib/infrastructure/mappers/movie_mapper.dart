import 'package:cinemapedia/configs/constants/environment.dart';
import 'package:cinemapedia/domain/entities/details.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieMovieDb movie) => Movie(
        id: movie.id,
        title: movie.title,
        posterPath: movie.posterPath != ''
            ? '${Environment.imageUrlPath}${movie.posterPath}'
            : 'NO_POSTER',
        overview: movie.overview,
        releaseDate:
            movie.releaseDate != null ? movie.releaseDate! : DateTime.now(),
        voteAverage: movie.voteAverage,
        voteCount: movie.voteCount,
        adult: movie.adult,
        backdropPath: movie.backdropPath != ''
            ? '${Environment.imageUrlPath}${movie.backdropPath}'
            : 'https://i.stack.imgur.com/GNhxO.png',
        genreIds: movie.genreIds.map((int e) => e.toString()).toList(),
        originalLanguage: movie.originalLanguage,
        originalTitle: movie.originalTitle,
        popularity: movie.popularity,
        video: movie.video,
      );

  static Movie movieDetailsToEntity(MovieDetails movie) => Movie(
        id: movie.id,
        title: movie.title,
        posterPath: movie.posterPath != null
            ? '${Environment.imageUrlPath}${movie.posterPath}'
            : 'https://i.stack.imgur.com/GNhxO.png',
        overview: movie.overview,
        releaseDate: movie.releaseDate,
        voteAverage: movie.voteAverage,
        voteCount: movie.voteCount,
        adult: movie.adult,
        backdropPath: movie.backdropPath != null
            ? '${Environment.imageUrlPath}${movie.backdropPath}'
            : 'https://i.stack.imgur.com/GNhxO.png',
        genreIds: movie.genres.map((e) => e.name).toList(),
        originalLanguage: movie.originalLanguage,
        originalTitle: movie.originalTitle,
        popularity: movie.popularity,
        video: movie.video,
      );
}
