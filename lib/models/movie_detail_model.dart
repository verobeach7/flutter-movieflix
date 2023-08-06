class MovieDetailModel {
  final String overview;
  final List<dynamic> genres;
  final int runtime;

  MovieDetailModel.fromJson(Map<String, dynamic> json)
      : overview = json["overview"],
        genres = json["genres"],
        runtime = json["runtime"];
}

// class Genres {
//   int? id;
//   String? name;

//   Genres({this.id, this.name});

//   Genres.fromJson(Map<String, dynamic> json) {
//     id = json["id"];
//     name = json["name"];
//   }
// }
