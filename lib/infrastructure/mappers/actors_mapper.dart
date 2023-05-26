import 'package:movie_app/domain/entities/movies/actor.dart';

import '../models/moviedb/the_moviedb_actors_response.dart';

const noImageFound =
    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/300px-No_image_available.svg.png";

const baseUrlImage = "https://image.tmdb.org/t/p/w500/";

class ActorsMapper {
  static Actor actorsMovieDbToEntity(Cast cast) => Actor(
      id: cast.id.toString(),
      name: cast.name,
      image: cast.profilePath == null
          ? noImageFound
          : baseUrlImage + cast.profilePath.toString(),
      rol: cast.character);
}
