import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/domain/entities/movies/movie.dart';
import 'package:movie_app/presentation/delegates/movie_search_delegate.dart';

import '../../providers/providers.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(children: [
            Icon(
              Icons.movie_outlined,
              color: colors.primary,
            ),
            const SizedBox(width: 5),
            Text(
              'Cartelera de peliculas por JFdeSousa',
              style: textStyle,
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  final movieRepository = ref.read(searchedMoviesProvider);
                  final String searchQuery = ref.read(searchQueryProvider);

                  showSearch<Movie?>(
                          query: searchQuery,
                          context: context,
                          delegate: MovieSearchDelegate(
                              searchMovie: ref
                                  .read(searchedMoviesProvider.notifier)
                                  .searchMovieByQuery,
                              initialMovies: movieRepository))
                      .then((value) {
                    if (value == null) return;

                    context.push('/home/0/movie/${value.id}');
                  });
                },
                icon: const Icon(Icons.search)),
          ]),
        ),
      ),
    );
  }
}
