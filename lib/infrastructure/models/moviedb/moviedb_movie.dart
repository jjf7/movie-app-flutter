class MoviedbMovie {
  final String posterPath;
  final bool adult;
  final String overview;
  final DateTime? releaseDate;
  final List<int> genreIds;
  final int id;
  final String originalTitle;
  final String originalLanguage;
  final String title;
  final String backdropPath;
  final double popularity;
  final int voteCount;
  final bool video;
  final double voteAverage;

  MoviedbMovie({
    required this.posterPath,
    required this.adult,
    required this.overview,
    required this.releaseDate,
    required this.genreIds,
    required this.id,
    required this.originalTitle,
    required this.originalLanguage,
    required this.title,
    required this.backdropPath,
    required this.popularity,
    required this.voteCount,
    required this.video,
    required this.voteAverage,
  });

  factory MoviedbMovie.fromJson(Map<String, dynamic> json) => MoviedbMovie(
        posterPath: json["poster_path"] ?? '',
        adult: json["adult"] ?? false,
        overview: json["overview"],
        releaseDate: json["release_date"] != null && json["release_date"] != ""
            ? DateTime.parse(json["release_date"])
            : null,
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalTitle: json["original_title"],
        originalLanguage: json["original_language"],
        title: json["title"],
        backdropPath: json["backdrop_path"] ?? '',
        popularity: json["popularity"]?.toDouble(),
        voteCount: json["vote_count"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
      );
}
