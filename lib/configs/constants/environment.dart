import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String theMovieDbKey = dotenv.env['THE_MOVIEDB_KEY'] ?? 'No hay llave';
  static String imageUrlPath =
      dotenv.env['IMAGE_URL_PATH'] ?? 'No hay path de imagen';
}
