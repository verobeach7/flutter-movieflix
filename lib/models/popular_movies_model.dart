class MoviesModel {
  final String backdropPath, overview, posterPath, title;
  final int id;
  final num voteAverage;

  MoviesModel.fromJson(Map<String, dynamic> json)
      : backdropPath = json["backdrop_path"],
        id = json["id"],
        overview = json["overview"],
        posterPath = json["poster_path"],
        title = json["title"],
        voteAverage = json["vote_average"];
}
