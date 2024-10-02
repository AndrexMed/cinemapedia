import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatasource extends LocalStorageDatasource {
  late Future<Isar> database;

  IsarDatasource() {
    database = openIsarDb();
  }

  Future<Isar> openIsarDb() async {
    //Instancia del directorio
    final dir = await getApplicationSupportDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [MovieSchema],
        inspector: true,
        directory: dir.path,
      );
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final isar = await database;

    final Movie? isFavoriteMovie =
        await isar.movies.filter().idEqualTo(movieId).findFirst();

    return isFavoriteMovie != null;
  }

  @override
  Future<List<Movie>> loadFavoritesMovies(
      {int limit = 10, int offset = 0}) async {
    //create method for loadFavoritesMovies
    final isar = await database;

    return isar.movies.where().offset(offset).limit(limit).findAll();
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final isar = await database;

    final Movie? favoriteMovie =
        await isar.movies.filter().idEqualTo(movie.id).findFirst();

    if (favoriteMovie != null) {
      isar.writeTxnSync(
        () => isar.movies.deleteSync(favoriteMovie.id),
      );
    }

    //Insertar o actualizar
    isar.writeTxnSync(
      () => isar.movies.putSync(movie),
    );
  }
}
