import '../entities/movies/actor.dart';

abstract class ActorsRepository {
  Future<List<Actor>> getActorsByMovieId(String id);
}
