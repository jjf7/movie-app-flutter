import 'moviedb_movie.dart';

class TheMoviedbResponse {
  final int page;
  final List<MoviedbMovie> results;
  final Dates? dates;
  final int totalPages;
  final int totalResults;

  TheMoviedbResponse({
    required this.page,
    required this.results,
    required this.dates,
    required this.totalPages,
    required this.totalResults,
  });

  factory TheMoviedbResponse.fromJson(Map<String, dynamic> json) =>
      TheMoviedbResponse(
        page: json["page"],
        results: List<MoviedbMovie>.from(
            json["results"].map((x) => MoviedbMovie.fromJson(x))),
        dates: json["dates"] ? Dates.fromJson(json["dates"]) : null,
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "dates": dates == null ? null : dates!.toJson(),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Dates {
  final DateTime maximum;
  final DateTime minimum;

  Dates({
    required this.maximum,
    required this.minimum,
  });

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
      );

  Map<String, dynamic> toJson() => {
        "maximum":
            "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}",
        "minimum":
            "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}",
      };
}
