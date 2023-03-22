import '../models/movie.dart';

class MovieState {
  final bool isError;
  final bool isSuccess;
  final String errMessage;
  final bool isLoad;
  final List<Movie> movies;
  final int page;
  MovieState(
      {required this.isError,
      required this.isSuccess,
      required this.errMessage,
      required this.isLoad,
      required this.movies,
      required this.page});

  MovieState copyWith({
    bool? isError,
    bool? isSuccess,
    String? errMessage,
    bool? isLoad,
    List<Movie>? movies,
    int? page,
  }) {
    return MovieState(
        isError: isError ?? this.isError,
        isSuccess: isSuccess ?? this.isSuccess,
        errMessage: errMessage ?? this.errMessage,
        isLoad: isLoad ?? this.isLoad,
        movies: movies ?? this.movies,
        page: page ?? this.page);
  }

  factory MovieState.empty() {
    return MovieState(
      isError: false,
      isSuccess: false,
      errMessage: '',
      isLoad: false,
      movies: [],
      page: 1,
    );
  }
}
