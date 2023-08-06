import 'package:flutter/material.dart';
import 'package:movieflix_clone/models/movie_detail_model.dart';
import 'package:movieflix_clone/services/api_service.dart';

class DetailScreen extends StatefulWidget {
  final String backdropPath, title, posterPath;
  final int id;
  final num voteAverage;
  static const String baseUrl = "https://image.tmdb.org/t/p/w500";

  const DetailScreen({
    super.key,
    required this.title,
    required this.id,
    required this.backdropPath,
    required this.voteAverage,
    required this.posterPath,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<MovieDetailModel> movieDetail;

  @override
  void initState() {
    super.initState();
    movieDetail = ApiService.getMovieDetail('${widget.id}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        fit: BoxFit.cover,
        image: NetworkImage(
          '${DetailScreen.baseUrl}${widget.posterPath}',
        ),
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            'Back to list',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            top: 240,
            left: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              WhichStar(widget.voteAverage),
              const SizedBox(
                height: 20,
              ),
              // Text(
              //   '${widget.voteAverage}',
              //   style: const TextStyle(
              //     color: Colors.white,
              //   ),
              // ),
              FutureBuilder(
                future: movieDetail,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Row(
                      children: [
                        Text(
                          '${snapshot.data!.runtime ~/ 60}h ${snapshot.data!.runtime % 60}min | ',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            letterSpacing: -1,
                          ),
                        ),
                        for (dynamic genre in snapshot.data!.genres)
                          Text(
                            '${genre['name']}, ',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(0.8),
                              letterSpacing: -1,
                            ),
                          ),
                      ],
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Storyline',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder(
                future: movieDetail,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 100,
                          bottom: 36,
                        ),
                        child: Text(
                          snapshot.data!.overview,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            letterSpacing: -1,
                          ),
                        ),
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 40,
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(
                        Color(0xFFF8D848),
                      ),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 80,
                        vertical: 20,
                      ),
                      child: Text(
                        'Buy ticket',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container WhichStar(num voteAverage) {
    final bool biggerZero = voteAverage >= 0 ? true : false;
    final bool biggerTwo = voteAverage >= 2 ? true : false;
    final bool biggerFour = voteAverage >= 4 ? true : false;
    final bool biggerSix = voteAverage >= 6 ? true : false;
    final bool biggerEight = voteAverage >= 8 ? true : false;

    return Container(
      child: Row(
        children: [
          Icon(
            Icons.star,
            color: biggerZero
                ? const Color(0xFFF8D848)
                : Colors.white.withOpacity(0.3),
          ),
          Icon(
            Icons.star,
            color: biggerTwo
                ? const Color(0xFFF8D848)
                : Colors.white.withOpacity(0.3),
          ),
          Icon(
            Icons.star,
            color: biggerFour
                ? const Color(0xFFF8D848)
                : Colors.white.withOpacity(0.3),
          ),
          Icon(
            Icons.star,
            color: biggerSix
                ? const Color(0xFFF8D848)
                : Colors.white.withOpacity(0.3),
          ),
          Icon(
            Icons.star,
            color: biggerEight
                ? const Color(0xFFF8D848)
                : Colors.white.withOpacity(0.3),
          ),
        ],
      ),
    );
  }
}
