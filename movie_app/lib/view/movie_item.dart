import 'package:flutter/material.dart';
import 'package:movie_app/domain/model/movie.dart';
import 'package:movie_app/utils/str_const.dart';
import 'package:toast/toast.dart';

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
    ToastContext().init(context);
    return Card(
      semanticContainer: true,
      elevation: DimensConst.elevation20,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DimensConst.radius12)),
      child: InkWell(
        onTap: () {
          Toast.show(
            'Click movie:${widget.movie.title}',
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
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      "${StrConst.baseImageUrl}${widget.movie.posterPath}"),
                ),
              ),
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: DimensConst.paddingAll8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        widget.movie.releaseDate.split('-')[0],
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.movie.title.toUpperCase(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )),
            Padding(
              padding: DimensConst.paddingAll8,
              child: Align(
                alignment: Alignment.topRight,
                child: Card(
                  semanticContainer: true,
                  elevation: DimensConst.elevation20,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Container(
                    padding:
                        EdgeInsets.only(top: 12, left: 8, right: 8, bottom: 8),
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: widget.movie.voteAverage.toString()[0],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        WidgetSpan(
                            child: Padding(
                          child: Text(
                            widget.movie.voteAverage.toString().length >= 3
                                ? ".${widget.movie.voteAverage.toString()[2]}"
                                : ".0",
                            style: TextStyle(
                                color: Colors.white60,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          padding: EdgeInsets.only(bottom: 6),
                        ))
                      ]),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          colors: [
                            Colors.orange,
                            Colors.orangeAccent,
                            Colors.pinkAccent,
                            Colors.pinkAccent
                            //add more colors for gradient
                          ],
                          begin: Alignment.topLeft,
                          //begin of the gradient color
                          end: Alignment.bottomRight,
                          //end of the gradient color
                          stops: [0, 0.4, 0.7, 0.9] //stops for individual color
                          //set the stops number equal to numbers of color
                          ),
                    ),
                  ),
                  color: Colors.transparent,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
