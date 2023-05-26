import 'package:movie_app/domain/datasources/movies_datasource.dart';
import 'package:movie_app/domain/entities/movies/movie.dart';
import 'package:movie_app/domain/entities/movies/video.dart';
import 'package:movie_app/domain/repositories/movie_repository.dart';

class MovieRepositoryImplementation extends MovieRepository {
  final MoviesDatasource datasource;

  MovieRepositoryImplementation(this.datasource);

  @override
  Future<List<Movie>> getNowPlaying({page = 1}) {
    return datasource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> topRating({int page = 1}) {
    return datasource.topRating(page: page);
  }

  @override
  Future<List<Movie>> upcoming({int page = 1}) {
    return datasource.upcoming(page: page);
  }

  @override
  Future<Movie> getMovie(String id) {
    return datasource.getMovie(id);
  }

  @override
  Future<List<Movie>> searchMovie(String query) {
    return datasource.searchMovie(query);
  }

  @override
  Future<List<Video>> getYoutubeVideosById(int movieId) {
    return datasource.getYoutubeVideosById(movieId);
  }
}
