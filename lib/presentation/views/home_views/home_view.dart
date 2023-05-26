import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatingMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    if (ref.watch(initialLoadingProvider)) return const FullScreenLoader();

    final movies = ref.watch(nowPlayingMoviesProvider);

    final moviesSlideshow = ref.watch(moviesSlideShowProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatingProvider = ref.watch(topRatingMoviesProvider);
    final upcomingProvider = ref.watch(upcomingMoviesProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: CustomAppbar(),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 1,
            (context, index) {
              return Column(
                children: [
                  MoviesSlideshow(movies: moviesSlideshow),
                  MovieHorizontalListView(
                    movies: movies,
                    title: 'En cines',
                    subtitle: 'Lunes 12',
                    loadNextPage: () => ref
                        .watch(nowPlayingMoviesProvider.notifier)
                        .loadNextPage(),
                  ),
                  MovieHorizontalListView(
                    movies: popularMovies,
                    title: 'Populares',
                    subtitle: 'Hot',
                    loadNextPage: () => ref
                        .watch(popularMoviesProvider.notifier)
                        .loadNextPage(),
                  ),
                  MovieHorizontalListView(
                    movies: topRatingProvider,
                    title: 'Top Rating',
                    subtitle: 'Tienes que verla',
                    loadNextPage: () => ref
                        .watch(topRatingMoviesProvider.notifier)
                        .loadNextPage(),
                  ),
                  MovieHorizontalListView(
                    movies: upcomingProvider,
                    title: 'Proximamente',
                    subtitle: 'Pronto en cines',
                    loadNextPage: () => ref
                        .watch(upcomingMoviesProvider.notifier)
                        .loadNextPage(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
