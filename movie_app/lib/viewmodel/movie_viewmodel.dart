import 'dart:async';

import 'package:movie_app/base/baseviewmodel/base_viewmodel.dart';
import 'package:movie_app/domain/model/movie.dart';
import 'package:movie_app/domain/model/movie_response.dart';
import 'package:movie_app/domain/service/api_service.dart';

class MovieViewModel extends BaseViewModel {
  static final MovieViewModel _instance = MovieViewModel._internal();

  factory MovieViewModel() {
    return _instance;
  }

  MovieViewModel._internal();

  ApiService apiService = ApiService();

  List<Movie> movieList = [];

  MovieResponse? movieResponse;

  @override
  FutureOr<void> init() {}

  Future<void> getListMovieByPage(int pageNumber) async {
    MovieResponse? movieResponse =
        await apiService.getListMovieByPage(pageNumber);
    if (movieResponse != null) {
      this.movieResponse = movieResponse;
      notifyListeners();
    }
  }

  onMoveListChanged(List<Movie> movies) {
    movieList += movies;
    notifyListeners();
  }
}
