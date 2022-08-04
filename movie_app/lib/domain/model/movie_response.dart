import 'movie.dart';

class MovieResponse {
  int page = 0;
  List<Movie> results = [];
  int totalPages = 0;
  int totalResults = 0;

  MovieResponse.fromJson(Map<dynamic, dynamic> json) {
    page = json['page'] as int;
    results = List<Movie>.from(
        json['results'].map((movieItem) => Movie.fromJson(movieItem)));
    totalPages = json['total_pages'] as int;
    totalResults = json['total_results'] as int;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'page': page,
        'results': results,
        'total_pages': totalPages,
        'total_results': totalResults,
      };
}
