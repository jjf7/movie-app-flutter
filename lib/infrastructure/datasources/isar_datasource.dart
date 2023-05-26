import 'dart:io';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'package:movie_app/domain/datasources/local_storage_datasource.dart';
import 'package:movie_app/domain/entities/movies/movie.dart';

class IsarDatasource extends LocalStorageDatasource {
  late Future<Isar> db;

  IsarDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([MovieSchema], directory: dir.path);
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final isar = await db;

    final Movie? isFavoriteMovie =
        await isar.movies.filter().idEqualTo(movieId).findFirst();

    return isFavoriteMovie != null;
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final isar = await db;

    final Movie? isFavoriteMovie =
        await isar.movies.filter().idEqualTo(movie.id).findFirst();

    isFavoriteMovie == null
        ? isar.writeTxnSync(() => isar.movies.putSync(movie))
        : isar.writeTxnSync(
            () => isar.movies.deleteSync(isFavoriteMovie.IsarId!));
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async {
    final isar = await db;

    final List<Movie> movies =
        await isar.movies.where().offset(offset).limit(limit).findAll();

    return movies;
  }
}
