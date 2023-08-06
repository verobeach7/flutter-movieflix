import 'package:flutter/material.dart';
import 'package:movieflix_clone/models/popular_movies_model.dart';
import 'package:movieflix_clone/services/api_service.dart';
import 'package:movieflix_clone/widgets/movie_widget.dart';
import 'package:movieflix_clone/widgets/only_poster_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // popular movies api 받아오기
  final Future<List<MoviesModel>> popularMovies = ApiService.getPopularMovies();

  // now in cinemas api 받아오기
  final Future<List<MoviesModel>> nowPlayingMovies = ApiService.getNowMovies();

  // coming soon api 받아오기
  final Future<List<MoviesModel>> comingSoonMovies =
      ApiService.getComingMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 120,
          ),
          child: SizedBox(
            height: 1000,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Text(
                    'Popular Movies',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -1,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                FutureBuilder(
                  future: popularMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: makePosterList(snapshot),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Text(
                    'Now in Cinemas',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -1,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                FutureBuilder(
                  future: nowPlayingMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: makeMovieList(snapshot),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Text(
                    'Coming soon',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -1,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                FutureBuilder(
                  future: comingSoonMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: makeMovieList(snapshot),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListView makePosterList(AsyncSnapshot<List<MoviesModel>> snapshot) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      itemBuilder: (context, index) {
        var movie = snapshot.data![index];
        return OnlyPoster(
          backdropPath: movie.backdropPath,
          id: movie.id,
          title: movie.title,
          voteAverage: movie.voteAverage,
          posterPath: movie.posterPath,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 40,
      ),
    );
  }

  ListView makeMovieList(AsyncSnapshot<List<MoviesModel>> snapshot) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      itemBuilder: (context, index) {
        var movie = snapshot.data![index];
        return Movie(
          backdropPath: movie.backdropPath,
          id: movie.id,
          title: movie.title,
          voteAverage: movie.voteAverage,
          posterPath: movie.posterPath,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 40,
      ),
    );
  }
}
