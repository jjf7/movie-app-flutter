import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import 'package:movie_app/domain/entities/movies/actor.dart';
import 'package:movie_app/presentation/providers/actors/actors_providers.dart';

class ActorHorizontalListView extends ConsumerStatefulWidget {
  final String movieId;

  const ActorHorizontalListView({
    super.key,
    required this.movieId,
  });

  @override
  ActorHorizontalListViewState createState() => ActorHorizontalListViewState();
}

class ActorHorizontalListViewState
    extends ConsumerState<ActorHorizontalListView> {
  @override
  void initState() {
    super.initState();
    ref.read(actorsProvider.notifier).getActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final List<Actor>? actors = ref.watch(actorsProvider)[widget.movieId];

    if (actors == null) {
      return const Center(
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: actors.length,
      itemBuilder: (context, index) {
        return _Slide(actor: actors[index]);
      },
    );
  }
}

class _Slide extends StatelessWidget {
  final Actor actor;

  const _Slide({required this.actor});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  actor.image,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                            child: CircularProgressIndicator(strokeWidth: 2)),
                      );
                    }
                    return FadeInRight(child: child);
                  },
                  width: 150,
                  fit: BoxFit.cover,
                )),
          ),
          const SizedBox(height: 5),

          //+ TITLE
          SizedBox(
              width: 150,
              child:
                  Text(actor.name, maxLines: 2, style: textStyle.titleSmall)),

          Text(
            actor.rol ?? '',
            maxLines: 2,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // const SizedBox(height: 5),
        ],
      ),
    );
  }
}
