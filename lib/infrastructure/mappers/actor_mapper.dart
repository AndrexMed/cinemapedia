import 'package:cinemapedia/configs/constants/environment.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';

class ActorMapper {
  static Actor actorDetailsToEntity(Cast actor) => Actor(
        id: actor.id,
        name: actor.name,
        profilePath: actor.profilePath != null
            ? '${Environment.imageUrlPath}${actor.profilePath}'
            : 'https://i.stack.imgur.com/GNhxO.png',
        character: actor.character,
      );
}
