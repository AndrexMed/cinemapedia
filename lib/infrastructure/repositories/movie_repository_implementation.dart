import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/repositories/movie_repository.dart';

import '../../domain/entities/entities.dart';

class MovieRepositoryImplementation extends MoviesRepository {
  final MoviesDatasource datasource;
  MovieRepositoryImplementation({required this.datasource});
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return datasource.getTopRated(page: page);
  }

  @override
  Future<List<Movie>> getUpComing({int page = 1}) {
    return datasource.getUpComing(page: page);
  }

  @override
  Future<Movie> getMovieById(String movieId) {
    return datasource.getMovieById(movieId);
  }

  @override
  Future<List<Movie>> searchMovies(String query) {
    return datasource.searchMovies(query);
  }

    @override
  Future<List<Movie>> getSimilarMovies(int movieId) {
    return datasource.getSimilarMovies(movieId);
  }
  
  @override
  Future<List<Video>> getYoutubeVideosById(int movieId) {
    return datasource.getYoutubeVideosById(movieId);
  }
}
