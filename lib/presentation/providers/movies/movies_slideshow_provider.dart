import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/domain/entities/movies/movie.dart';

import 'movies_providers.dart';

final moviesSlideShowProvider = Provider<List<Movie>>((ref) {
  final movies = ref.watch(nowPlayingMoviesProvider);

  if (movies.isEmpty) return [];

  return movies.sublist(0, 10);
});
