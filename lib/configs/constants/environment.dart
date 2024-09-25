import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String apiUrlBase = dotenv.env['API_URL_BASE'] ?? 'No hay url';
  static String theMovieDbKey = dotenv.env['THE_MOVIEDB_KEY'] ?? 'No hay llave';
  static String imageUrlPath =
      dotenv.env['IMAGE_URL_PATH'] ?? 'No hay path de imagen';
}
