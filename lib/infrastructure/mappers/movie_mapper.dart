import 'package:cinemapedia/configs/constants/environment.dart';
import 'package:cinemapedia/domain/entities/details.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieMovieDb movie) => Movie(
        id: movie.id,
        title: movie.title,
        posterPath: (movie.posterPath != '')
            ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
            : 'https://www.movienewz.com/img/films/poster-holder.jpg',
        overview: movie.overview,
        releaseDate:
            movie.releaseDate != null ? movie.releaseDate! : DateTime.now(),
        voteAverage: movie.voteAverage,
        voteCount: movie.voteCount,
        adult: movie.adult,
        backdropPath: (movie.backdropPath != '')
            ? 'https://image.tmdb.org/t/p/w500${movie.backdropPath}'
            : 'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg',
        genreIds: movie.genreIds.map((int e) => e.toString()).toList(),
        originalLanguage: movie.originalLanguage,
        originalTitle: movie.originalTitle,
        popularity: movie.popularity,
        video: movie.video,
      );

  static Movie movieDetailsToEntity(MovieDetails movie) => Movie(
        id: movie.id,
        title: movie.title,
        posterPath: (movie.posterPath != '')
            ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
            : 'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg',
        overview: movie.overview,
        releaseDate: movie.releaseDate,
        voteAverage: movie.voteAverage,
        voteCount: movie.voteCount,
        adult: movie.adult,
        backdropPath: (movie.backdropPath != '')
            ? 'https://image.tmdb.org/t/p/w500${movie.backdropPath}'
            : 'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg',
        genreIds: movie.genres.map((e) => e.name).toList(),
        originalLanguage: movie.originalLanguage,
        originalTitle: movie.originalTitle,
        popularity: movie.popularity,
        video: movie.video,
      );
}
