class Movie {
  final String title;
  final String backdrop_path;
  final int id;
  final String poster_path;
  final String vote_average;
  final String overview;

  Movie({
    required this.backdrop_path,
    required this.id,
    required this.poster_path,
    required this.vote_average,
    required this.overview,
    required this.title,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      backdrop_path: json['backdrop_path'],
      id: json['id'],
      poster_path:
          'https://image.tmdb.org/t/p/w600_and_h900_bestv2/${json['poster_path']}',
      vote_average: '${json['vote_average']}',
      overview: json['overview'],
      title: json['title'],
    );
  }
  @override
  String toString() {
    // TODO: implement toString
    return 'Movie('
        'title: $title'
        ')';
  }
}
