import 'package:movie_app/domain/entities/movies/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getNowPlaying({page = 1});
}
