import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movieflix_clone/models/movie_detail_model.dart';
import 'package:movieflix_clone/models/popular_movies_model.dart';

class ApiService {
  static const String baseUrl = "https://movies-api.nomadcoders.workers.dev";
  static const String popular = "popular";
  static const String nowPlaying = "now-playing";
  static const String comingSoon = "coming-soon";

  // getPopularMovies()
  static Future<List<MoviesModel>> getPopularMovies() async {
    List<MoviesModel> moviesInstances = [];
    final url = Uri.parse('$baseUrl/$popular');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> popularMovies = jsonDecode(response.body)['results'];
      for (var movie in popularMovies) {
        final instance = MoviesModel.fromJson(movie);
        moviesInstances.add(instance);
      }
      return moviesInstances;
    }
    throw Error();
  }

  // getNowMovies()
  static Future<List<MoviesModel>> getNowMovies() async {
    List<MoviesModel> moviesInstances = [];
    final url = Uri.parse('$baseUrl/$nowPlaying');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> nowPlayingMovies =
          jsonDecode(response.body)['results'];
      for (var movie in nowPlayingMovies) {
        final instance = MoviesModel.fromJson(movie);
        moviesInstances.add(instance);
      }
      return moviesInstances;
    }
    throw Error();
  }

  // getComingMovies()
  static Future<List<MoviesModel>> getComingMovies() async {
    List<MoviesModel> moviesInstances = [];
    final url = Uri.parse('$baseUrl/$comingSoon');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> comingSoonMovies =
          jsonDecode(response.body)['results'];
      for (var movie in comingSoonMovies) {
        final instance = MoviesModel.fromJson(movie);
        moviesInstances.add(instance);
      }
      return moviesInstances;
    }
    throw Error();
  }

  // getMovieDetailById()
  static Future<MovieDetailModel> getMovieDetail(String id) async {
    final url = Uri.parse('$baseUrl/movie?id=$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final movieDetail = jsonDecode(response.body);
      return MovieDetailModel.fromJson(movieDetail);
    }
    throw Error();
  }
}
