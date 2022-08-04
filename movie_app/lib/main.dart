import 'package:flutter/material.dart';
import 'package:movie_app/view/popular_screen.dart';
import 'package:movie_app/viewmodel/movie_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => MovieViewModel(),
      ),
    ],
    child: Builder(builder: (context) {
      return MyApp();
    }),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<MovieViewModel>(context, listen: true);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PopularScreen(),
    );
  }
}
