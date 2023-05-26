import 'package:movie_app/domain/entities/movies/actor.dart';

abstract class ActorsDataSource {
  Future<List<Actor>> getActorsByMovieId(String id);
}
