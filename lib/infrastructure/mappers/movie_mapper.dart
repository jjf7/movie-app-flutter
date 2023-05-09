import 'package:movie_app/domain/entities/movies/movie.dart';

import '../models/moviedb/moviedb_movie.dart';

const noImageFound =
    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/300px-No_image_available.svg.png";

class MovieMapper {
  static Movie movieDBToEntity(MoviedbMovie movieDb) => Movie(
      adult: movieDb.adult,
      backdropPath:
          movieDb.backdropPath != "" ? movieDb.backdropPath : noImageFound,
      genreIds: movieDb.genreIds.map((e) => e.toString()).toList(),
      id: movieDb.id,
      originalLanguage: movieDb.originalLanguage,
      originalTitle: movieDb.originalTitle,
      overview: movieDb.overview,
      popularity: movieDb.popularity,
      posterPath: movieDb.posterPath != "" ? movieDb.posterPath : 'no-poster',
      releaseDate: movieDb.releaseDate,
      title: movieDb.title,
      video: movieDb.video,
      voteAverage: movieDb.voteAverage,
      voteCount: movieDb.voteCount);
}
