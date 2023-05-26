import 'package:dio/dio.dart';
import 'package:movie_app/config/constants/environment.dart';
import 'package:movie_app/domain/datasources/actors_datasource.dart';
import 'package:movie_app/domain/entities/movies/actor.dart';

import '../mappers/actors_mapper.dart';
import '../models/moviedb/the_moviedb_actors_response.dart';

class ActorsDataSourceImpl extends ActorsDataSource {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.themMovieDbKey,
      'language': 'es-MX'
    },
  ));

  @override
  Future<List<Actor>> getActorsByMovieId(String id) async {
    final response = await dio.get('/movie/$id/credits');

    List<Actor> actors = TheMoviedbActorsResponse.fromJson(response.data)
        .cast
        .map((cast) => ActorsMapper.actorsMovieDbToEntity(cast))
        .toList();

    return actors;
  }
}
