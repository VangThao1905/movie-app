import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/view/movie_item.dart';
import 'package:movie_app/viewmodel/movie_viewmodel.dart';
import 'package:toast/toast.dart';

import '../domain/model/movie.dart';

class PopularScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PopularScreen();
}

class _PopularScreen extends State<PopularScreen> {
  MovieViewModel movieViewModel = MovieViewModel();

  late StreamSubscription<List<Movie>> movieSubscription;

  static const double _endReachedThreshold = 200;

  final ScrollController _controller = ScrollController();

  int _nextPage = 1;
  bool _loading = true;
  bool _canLoadMore = true;

  @override
  void initState() {
    _controller.addListener(_onScroll);
    _getMovies();
    super.initState();
  }

  @override
  void dispose() {
    movieSubscription.cancel();
    super.dispose();
  }

  Future<void> _getMovies() async {
    _loading = true;

    await movieViewModel.getListMovieByPage(_nextPage);

    setState(() {
      movieViewModel.onMoveListChanged(movieViewModel.movieResponse!.results);

      _nextPage++;

      if (movieViewModel.movieList.length < 20) {
        _canLoadMore = false;
      }

      _loading = false;
    });
  }

  void _onScroll() {
    if (!_controller.hasClients || _loading) return;

    final thresholdReached =
        _controller.position.extentAfter < _endReachedThreshold;

    if (thresholdReached) {
      _getMovies();
    }
  }

  Future<void> _refresh() async {
    _canLoadMore = true;
    movieViewModel.movieList.clear();
    _nextPage = 1;
    await _getMovies();
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        titleSpacing: 0,
        leading: IconButton(
          padding: EdgeInsets.only(left: 24),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Toast.show(
              'Action back',
              duration: Toast.lengthLong,
              gravity: Toast.bottom,
              backgroundRadius: 4,
              textStyle: const TextStyle(
                  height: 1.2,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 12),
            );
          },
        ),
        leadingWidth: 32,
        title: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            "Back",
            style: TextStyle(color: Colors.black),
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 16, left: 16, bottom: 16),
                child: Text(
                  "Popular list",
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              )),
          Expanded(
            child: CustomScrollView(
              controller: _controller,
              slivers: <Widget>[
                CupertinoSliverRefreshControl(
                  onRefresh: _refresh,
                ),
                SliverPadding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 2 / 3,
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      ((BuildContext context, int index) {
                        return MovieItem(
                          movie: movieViewModel.movieList[index],
                        );
                      }),
                      childCount: movieViewModel.movieList.length,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: _canLoadMore
                      ? Container(
                          padding: EdgeInsets.only(bottom: 16),
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        )
                      : const SizedBox(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
