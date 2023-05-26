import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:movie_app/presentation/providers/providers.dart';
import 'package:movie_app/presentation/widgets/widgets.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLoading = false;
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;

    final movies =
        await ref.read(favoritesMoviesProvider.notifier).loadNextPage();

    isLoading = false;

    if (movies.isEmpty) isLastPage = true;
  }

  @override
  Widget build(BuildContext context) {
    final movies = ref.watch(favoritesMoviesProvider).values.toList();

    // final List<Movie> movies = [];
    // mapMovies.forEach((key, value) {
    //   movies.add(value);
    // });

    if (movies.isEmpty) {
      final colors = Theme.of(context).colorScheme;
      return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite_outline_outlined,
                color: colors.primary,
                size: 70,
              ),
              Text(
                "Ohhh no!!",
                style: TextStyle(fontSize: 30, color: colors.primary),
              ),
              Text(
                "no tienes peliculas favoritas",
                style: TextStyle(fontSize: 20, color: colors.secondary),
              ),
              const SizedBox(
                height: 20,
              ),
              FadeIn(
                child: FilledButton.tonal(
                    onPressed: () => context.go('/'),
                    child: const Text("Empieza a buscar")),
              )
            ]),
      );
    }

    return Scaffold(
      body: MovieMasonry(
        movies: movies,
        loadNextPage: loadNextPage,
      ),
    );
  }
}
