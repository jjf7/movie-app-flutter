import 'package:movie_app/domain/datasources/actors_datasource.dart';
import 'package:movie_app/domain/entities/movies/actor.dart';
import 'package:movie_app/domain/repositories/actors_repository.dart';

class ActorsRepositoryImpl extends ActorsRepository {
  final ActorsDataSource datasource;

  ActorsRepositoryImpl(this.datasource);

  @override
  Future<List<Actor>> getActorsByMovieId(String id) {
    return datasource.getActorsByMovieId(id);
  }
}
