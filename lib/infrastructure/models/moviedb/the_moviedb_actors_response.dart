class TheMoviedbActorsResponse {
  final int id;
  final List<Cast> cast;
  final List<Cast> crew;

  TheMoviedbActorsResponse({
    required this.id,
    required this.cast,
    required this.crew,
  });

  factory TheMoviedbActorsResponse.fromJson(Map<String, dynamic> json) =>
      TheMoviedbActorsResponse(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
        crew: List<Cast>.from(json["crew"].map((x) => Cast.fromJson(x))),
      );
}

class Cast {
  final bool adult;
  final int gender;
  final int id;
  final Department? knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final int? castId;
  final String? character;
  final String creditId;
  final int? order;
  final Department? department;
  final String? job;

  Cast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    required this.creditId,
    this.order,
    this.department,
    this.job,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"] != null
            ? departmentValues.map[json["known_for_department"]]
            : null,
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"]?.toDouble(),
        profilePath: json["profile_path"],
        castId: json["cast_id"],
        character: json["character"],
        creditId: json["credit_id"],
        order: json["order"],
        department: json["department"] != null
            ? departmentValues.map[json["department"]]
            : null,
        job: json["job"],
      );
}

enum Department {
  ACTING,
  EDITING,
  PRODUCTION,
  SOUND,
  WRITING,
  ART,
  CREW,
  VISUAL_EFFECTS,
  DIRECTING,
  LIGHTING,
  CAMERA
}

final departmentValues = EnumValues({
  "Acting": Department.ACTING,
  "Art": Department.ART,
  "Camera": Department.CAMERA,
  "Crew": Department.CREW,
  "Directing": Department.DIRECTING,
  "Editing": Department.EDITING,
  "Lighting": Department.LIGHTING,
  "Production": Department.PRODUCTION,
  "Sound": Department.SOUND,
  "Visual Effects": Department.VISUAL_EFFECTS,
  "Writing": Department.WRITING
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
