import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:movie_app/domain/entities/movies/movie.dart';

import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class MovieScreen extends StatelessWidget {
  static const String name = "movie-screen";
  final String movieId;
  const MovieScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _ViewDetails(movieId: movieId));
  }
}

class _ViewDetails extends ConsumerStatefulWidget {
  final String movieId;
  const _ViewDetails({required this.movieId});

  @override
  _ViewDetailsState createState() => _ViewDetailsState();
}

class _ViewDetailsState extends ConsumerState<_ViewDetails> {
  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) {
      return const Center(
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }

    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        _CustomSliverAppBar(movie),
        SliverList(
          delegate: SliverChildBuilderDelegate(
              (context, index) => _MovieDetails(movie: movie),
              childCount: 1),
        ),
      ],
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;

  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.3,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(movie.title,
                          style: textStyle.titleLarge,
                          textAlign: TextAlign.start),
                      Text(movie.overview)
                    ]),
              ),
            ],
          ),
        ),

        // Generos de la pelicula
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(children: [
            ...movie.genreIds
                .map((genre) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      child: Chip(
                          label: Text(genre), shape: const StadiumBorder()),
                    ))
                .toList()
          ]),
        ),

        // Mostrar actores
        const SizedBox(height: 10),
        SizedBox(
          height: 300,
          width: double.infinity,
          child: _ActorsView(
            movieId: movie.id.toString(),
          ),
        ),

        const SizedBox(height: 50),
        //* Videos de la película (si tiene)
        VideosFromMovie(movieId: movie.id),

        const SizedBox(height: 50)
      ],
    );
  }
}

class _ActorsView extends StatelessWidget {
  final String movieId;
  const _ActorsView({required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ActorHorizontalListView(movieId: movieId),
    );
  }
}

final isFavoriteProvider =
    FutureProvider.family.autoDispose((ref, int movieId) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return localStorageRepository.isMovieFavorite(movieId);
});

class _CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;
  const _CustomSliverAppBar(this.movie);

  @override
  Widget build(BuildContext context, ref) {
    final Size size = MediaQuery.of(context).size;

    final isFavoriteFutureProvider = ref.watch(isFavoriteProvider(movie.id));

    return SliverAppBar(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      expandedHeight: size.height * 0.7,
      actions: [
        IconButton(
          onPressed: () async {
            //ref.watch(localStorageRepositoryProvider).toggleFavorite(movie);

            await ref
                .read(favoritesMoviesProvider.notifier)
                .toggleFavorite(movie);
            ref.invalidate(isFavoriteProvider(movie.id));
          },
          icon: isFavoriteFutureProvider.when(
              data: (data) => data
                  ? const Icon(
                      Icons.favorite_rounded,
                      color: Colors.red,
                      size: 30,
                    )
                  : const Icon(
                      Icons.favorite_border,
                      size: 30,
                    ),
              error: (_, __) => throw UnimplementedError(),
              loading: () => const CircularProgressIndicator(
                    strokeWidth: 2,
                  )),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        centerTitle: true,
        background: Stack(children: [
          SizedBox.expand(
            child: Image.network(
              movie.posterPath,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress != null) return const SizedBox();

                return FadeIn(child: child);
              },
            ),
          ),
          const _CustomGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.0, 0.2],
            colors: [Colors.black54, Colors.transparent],
          ),
          const _CustomGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.8, 1.0],
              colors: [Colors.transparent, Colors.black54]),
          const _CustomGradient(
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
              stops: [0.0, 0.3],
              colors: [Colors.black87, Colors.transparent]),
        ]),
      ),
    );
  }
}

class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double>? stops;
  final List<Color> colors;

  const _CustomGradient(
      {required this.begin,
      required this.end,
      this.stops,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
          decoration: BoxDecoration(
              gradient: LinearGradient(
        begin: begin,
        end: end,
        stops: stops,
        colors: colors,
      ))),
    );
  }
}
