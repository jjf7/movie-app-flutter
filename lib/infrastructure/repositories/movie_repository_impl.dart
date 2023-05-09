import 'package:movie_app/domain/datasources/movies_datasource.dart';
import 'package:movie_app/domain/entities/movies/movie.dart';
import 'package:movie_app/domain/repositories/movie_repository.dart';

class MovieRepositoryImplementation extends MovieRepository {
  final MoviesDatasource datasource;

  MovieRepositoryImplementation(this.datasource);

  @override
  Future<List<Movie>> getNowPlaying({page = 1}) {
    return datasource.getNowPlaying(page: page);
  }
}
