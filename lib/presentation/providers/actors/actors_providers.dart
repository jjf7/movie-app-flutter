import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/domain/entities/movies/actor.dart';

import 'actors_repository_provider.dart';

final actorsProvider =
    StateNotifierProvider<ActorsNotifier, Map<String, List<Actor>>>((ref) {
  final getActorsByMovieId =
      ref.watch(actorsRepositoryProvider).getActorsByMovieId;
  return ActorsNotifier(getActorsByMovieId);
});

typedef ActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorsNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final ActorsCallback getActorsByMovieId;

  ActorsNotifier(this.getActorsByMovieId) : super({});

  Future<void> getActors(String movieId) async {
    if (state[movieId] != null) return;

    List<Actor> actors = await getActorsByMovieId(movieId);

    state = {...state, movieId: actors};
  }
}
