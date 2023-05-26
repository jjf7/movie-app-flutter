import 'package:dio/dio.dart';

import 'package:movie_app/config/constants/environment.dart';
import 'package:movie_app/domain/datasources/movies_datasource.dart';
import 'package:movie_app/domain/entities/movies/movie.dart';
import 'package:movie_app/domain/entities/movies/video.dart';
import 'package:movie_app/infrastructure/mappers/movie_mapper.dart';
import 'package:movie_app/infrastructure/mappers/video_mapper.dart';
import 'package:movie_app/infrastructure/models/moviedb/moviedb_videos.dart';
import 'package:movie_app/infrastructure/models/moviedb/the_moviedb_response.dart';

import '../models/moviedb/moviedb_details.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.themMovieDbKey,
      'language': 'es-MX'
    },
  ));

  Future<List<Movie>> getHttpResponse(Map<String, dynamic> json) async {
    List<Movie> movies = TheMoviedbResponse.fromJson(json)
        .results
        .where((movieDbMovie) => movieDbMovie.posterPath != "no-poster")
        .map((movieDbmovie) => MovieMapper.movieDBToEntity(movieDbmovie))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({page = 1}) async {
    final response =
        await dio.get('/movie/now_playing', queryParameters: {'page': page});

    return getHttpResponse(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response =
        await dio.get('/movie/popular', queryParameters: {'page': page});

    return getHttpResponse(response.data);
  }

  @override
  Future<List<Movie>> topRating({int page = 1}) async {
    final response =
        await dio.get('/movie/top_rated', queryParameters: {'page': page});

    return getHttpResponse(response.data);
  }

  @override
  Future<List<Movie>> upcoming({int page = 1}) async {
    final response =
        await dio.get('/movie/upcoming', queryParameters: {'page': page});

    return getHttpResponse(response.data);
  }

  @override
  Future<Movie> getMovie(String id) async {
    if (id == '') return throw UnimplementedError();
    final response = await dio.get('/movie/$id');

    Movie movie = MovieMapper.moviedbDetailsToEntity(
        MoviedbDetails.fromJson(response.data));

    return movie;
  }

  @override
  Future<List<Movie>> searchMovie(String query) async {
    if (query.isEmpty) return [];

    final response =
        await dio.get('/search/movie', queryParameters: {'query': query});

    return getHttpResponse(response.data);
  }

  @override
  Future<List<Video>> getYoutubeVideosById(int movieId) async {
    final response = await dio.get('/movie/$movieId/videos');
    final moviedbVideosReponse = MoviedbVideosResponse.fromJson(response.data);
    final videos = <Video>[];

    for (final moviedbVideo in moviedbVideosReponse.results) {
      if (moviedbVideo.site == 'YouTube') {
        final video = VideoMapper.moviedbVideoToEntity(moviedbVideo);
        videos.add(video);
      }
    }

    return videos;
  }
}
