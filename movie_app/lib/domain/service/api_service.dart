import 'dart:convert';

import 'package:movie_app/domain/model/movie.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/utils/str_const.dart';

import '../model/movie_response.dart';

class ApiService {
  String baseUrl =
      "https://api.themoviedb.org/3/discover/movie?api_key=${StrConst.apiKey}&page=";

  Future<MovieResponse?> getListMovieByPage(int pageNumber) async {
    final response = await http.get(Uri.parse("$baseUrl$pageNumber"));

    if (response.statusCode == 200) {
      final bodyResponse = jsonDecode(response.body);
      print("json body:${bodyResponse}");
      MovieResponse movieResponse = MovieResponse.fromJson(bodyResponse);
      print("movie response:${movieResponse.toJson()}");
      return movieResponse;
    } else {
      throw Exception("Error to get movies");
    }
  }
}
