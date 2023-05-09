import 'package:dio/dio.dart';

import 'package:movie_app/config/constants/environment.dart';
import 'package:movie_app/domain/datasources/movies_datasource.dart';
import 'package:movie_app/domain/entities/movies/movie.dart';
import 'package:movie_app/infrastructure/mappers/movie_mapper.dart';
import 'package:movie_app/infrastructure/models/moviedb/the_moviedb_response.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.themMovieDbKey,
      'language': 'es-MX'
    },
  ));

  @override
  Future<List<Movie>> getNowPlaying({page = 1}) async {
    final response = await dio.get('/movie/now_playing');

    List<Movie> movies = TheMoviedbResponse.fromJson(response.data)
        .results
        .where((movieDbMovie) => movieDbMovie.posterPath != "no-poster")
        .map((movieDbmovie) => MovieMapper.movieDBToEntity(movieDbmovie))
        .toList();

    return movies;
  }
}
