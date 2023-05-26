import 'package:movie_app/domain/entities/movies/movie.dart';

import '../entities/movies/video.dart';

abstract class MovieRepository {
  Future<List<Movie>> getNowPlaying({page = 1});
  Future<List<Movie>> getPopular({int page = 1});
  Future<List<Movie>> topRating({int page = 1});
  Future<List<Movie>> upcoming({int page = 1});
  Future<Movie> getMovie(String id);
  Future<List<Movie>> searchMovie(String query);
  Future<List<Video>> getYoutubeVideosById(int movieId);
}
