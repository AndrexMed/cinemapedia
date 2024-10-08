import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>(
        (ref) {
  final actorsRepository = ref.watch(actorsRepositoryProvider);

  return ActorsByMovieNotifier(
      getActorsByMovie: actorsRepository.getActorsByMovie);
});

typedef GetActorsByMovieCallback = Future<List<Actor>> Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsByMovieCallback getActorsByMovie;
  ActorsByMovieNotifier({required this.getActorsByMovie}) : super({});

  Future<void> loadActors(String movieId) async {
    if (state.containsKey(movieId)) return;

    final List<Actor> actors = await getActorsByMovie(movieId);
    state = {...state, movieId: actors};
  }
}
