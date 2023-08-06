import 'package:flutter/material.dart';
import 'package:movieflix_clone/screens/detail_screen.dart';

class OnlyPoster extends StatelessWidget {
  final String backdropPath, title, posterPath;
  // posterPath 추가
  final int id;
  final num voteAverage;
  static const String baseUrl = "https://image.tmdb.org/t/p/w500";

  const OnlyPoster({
    super.key,
    required this.backdropPath,
    required this.id,
    required this.title,
    required this.voteAverage,
    required this.posterPath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              backdropPath: backdropPath,
              id: id,
              title: title,
              voteAverage: voteAverage,
              posterPath: posterPath,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: 340,
            height: 240,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Image.network(
              '$baseUrl$backdropPath',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
