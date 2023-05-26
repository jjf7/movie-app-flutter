import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/domain/entities/movies/movie.dart';

import 'package:movie_app/presentation/providers/movies/movies_repository_provider.dart';

/*
{
  '12233': Instancia de Movie
  '12233': Instancia de Movie
  '12213': Instancia de Movie
  '33834': Instancia de Movie
}
*/

final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final fetchMovie = ref.watch(movieRepositoryProvider).getMovie;

  return MovieMapNotifier(getMovie: fetchMovie);
});

typedef GetMovieCallback = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback getMovie;
  MovieMapNotifier({required this.getMovie}) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;
    Movie movie = await getMovie(movieId);

    state = {...state, movieId: movie};
  }
}
