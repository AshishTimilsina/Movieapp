import '../models/movie.dart';

class SearchState {
  final bool isError;
  final bool isSuccess;
  final String errMessage;
  final bool isLoad;
  final List<Movie> movies;
  final int page;
  SearchState({
    required this.isError,
    required this.isSuccess,
    required this.errMessage,
    required this.isLoad,
    required this.movies,
    required this.page,
  });

  SearchState copyWith({
    bool? isError,
    bool? isSuccess,
    String? errMessage,
    bool? isLoad,
    List<Movie>? movies,
    int? page,
  }) {
    return SearchState(
        isError: isError ?? this.isError,
        isSuccess: isSuccess ?? this.isSuccess,
        errMessage: errMessage ?? this.errMessage,
        isLoad: isLoad ?? this.isLoad,
        movies: movies ?? this.movies,
        page: page ?? this.page);
  }

  factory SearchState.empty() {
    return SearchState(
      isError: false,
      isSuccess: false,
      errMessage: '',
      isLoad: false,
      movies: [],
      page: 1,
    );
  }
}
