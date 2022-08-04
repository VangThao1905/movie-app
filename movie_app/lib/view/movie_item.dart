import 'package:flutter/material.dart';
import 'package:movie_app/domain/model/movie.dart';
import 'package:movie_app/utils/str_const.dart';

import '../utils/DimensConst.dart';

class MovieItem extends StatefulWidget {
  Movie movie;

  MovieItem({required this.movie});

  @override
  State<StatefulWidget> createState() => _MovieItem();
}

class _MovieItem extends State<MovieItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      elevation: DimensConst.elevation20,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DimensConst.radius12)),
      child: InkWell(
        onTap: () {
          print("tap view");
        },
        child: Container(
          // padding: DimensConst.paddingAll16,
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage("${StrConst.baseImageUrl}${widget.movie.posterPath}"),
                  ),
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(DimensConst.radius12)),

        ),
      ),
    );
  }
}
