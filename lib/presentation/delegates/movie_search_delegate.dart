import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:movie_app/config/helpers/human_formats.dart';
import 'package:movie_app/domain/entities/movies/movie.dart';

typedef FunctionCallback = Future<List<Movie>> Function(String searchMovie);

class MovieSearchDelegate extends SearchDelegate<Movie?> {
  final FunctionCallback searchMovie;
  List<Movie> initialMovies;

  StreamController<List<Movie>> streamController =
      StreamController<List<Movie>>.broadcast();

  StreamController<bool> isLoading = StreamController.broadcast();

  Timer? _debounceTimer;

  MovieSearchDelegate({required this.searchMovie, required this.initialMovies});

  void _onQueryChanged(String query) {
    isLoading.add(true);
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      // buscando peliculas
      final movies = await searchMovie(query);
      initialMovies = movies;
      streamController.add(movies);
      isLoading.add(false);
    });
  }

  Widget buildSugestionAndResults() {
    return StreamBuilder(
      initialData: initialMovies,
      stream: streamController.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
        }
        final movies = snapshot.data;

        return ListView.builder(
          itemCount: movies!.length,
          itemBuilder: (context, index) => MovieItem(
              movie: movies[index],
              close: close,
              streamController: streamController),
        );
      },
    );
  }

  @override
  String get searchFieldLabel => "Buscar pelicula";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
          initialData: false,
          stream: isLoading.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                return !snapshot.data!
                    ? FadeIn(
                        animate: query.isNotEmpty,
                        child: IconButton(
                            onPressed: () {
                              query = '';
                            },
                            icon: const Icon(Icons.close_rounded)),
                      )
                    : SpinPerfect(
                        infinite: true,
                        animate: query.isNotEmpty,
                        child: IconButton(
                            onPressed: () {
                              query = '';
                            },
                            icon: const Icon(Icons.refresh_rounded)),
                      );
              } else {
                return Container();
              }
            } else {
              return Container();
            }
          }),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
          //streamController.close();
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSugestionAndResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //streamController.add(searchMovie);

    _onQueryChanged(query);

    return buildSugestionAndResults();
  }
}

class MovieItem extends StatelessWidget {
  final Movie movie;
  final Function close;
  final StreamController streamController;
  const MovieItem({
    super.key,
    required this.movie,
    required this.close,
    required this.streamController,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        close(context, movie);
        //streamController.close();
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInLeft(
                    child: Image.network(
                      movie.posterPath,
                      fit: BoxFit.cover,
                    ),
                  )),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: textStyle.bodyLarge,
                  ),
                  Text(
                    movie.overview.length > 100
                        ? '${movie.overview.toString().substring(0, 100)}...'
                        : movie.overview,
                    style: textStyle.bodyMedium,
                  ),
                  Row(
                    children: [
                      Icon(Icons.star_half_rounded,
                          color: Colors.yellow.shade600),
                      const SizedBox(width: 5),
                      Text(HumanFormats.number(movie.voteAverage, 1).toString(),
                          style: textStyle.bodySmall!
                              .copyWith(color: Colors.yellow.shade900)),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
