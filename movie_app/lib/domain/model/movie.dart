class Movie {
  bool adult = false;
  String? backdropPath = "";
  List<int> genreIds = [];
  int id = 0;
  String originalLanguage = "en";
  String originalTitle = "";
  String overview = "";
  double popularity = 0.0;
  String? posterPath = "";
  String releaseDate = "";
  String title = "";
  bool video = false;
  num voteAverage = 0.0;
  int voteCount = 0;

  Movie(
      {required this.adult,
      required this.backdropPath,
      required this.genreIds,
      required this.id,
      required this.originalLanguage,
      required this.originalTitle,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.releaseDate,
      required this.title,
      required this.video,
      required this.voteAverage,
      required this.voteCount});

  Movie.fromJson(Map<dynamic, dynamic> json) {
    adult = json['adult'] as bool;
    backdropPath = json['backdrop_path'] as String?;
    genreIds =
        List<int>.from(json['genre_ids'].map((movieItem) => movieItem as int));
    id = json['id'] as int;
    originalLanguage = json['original_language'] as String;
    originalTitle = json['original_title'] as String;
    overview = json['overview'] as String;
    popularity = json['popularity'] as double;
    posterPath = json['poster_path'] as String?;
    releaseDate = json['release_date'] as String;
    title = json['title'] as String;
    video = json['video'] as bool;
    voteAverage = json['vote_average'] as num;
    voteCount = json['vote_count'] as int;
  }
}
