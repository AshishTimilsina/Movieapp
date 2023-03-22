import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mymovieapp/services/movie_services.dart';
import 'package:mymovieapp/states/moviestate.dart';

final movieprovider =
    StateNotifierProvider.family<MovieProvider, MovieState, String>(
        (ref, String api) => MovieProvider(
            MovieState.empty(), ref.watch(movieserviceProvider), api));

class MovieProvider extends StateNotifier<MovieState> {
  final MovieService services;
  final String apiPath;
  MovieProvider(super.state, this.services, this.apiPath) {
    getdata();
  }

  Future<void> getdata() async {
    state = state.copyWith(
        isError: false, isSuccess: false, errMessage: '', isLoad: true);
    final response = await services.getdata(apiPath: apiPath, page: state.page);
    response.fold((l) {
      state = state.copyWith(
        isLoad: false,
        movies: [],
        isError: true,
        errMessage: l,
        isSuccess: false,
      );
    }, (r) {
      state = state.copyWith(
        errMessage: '',
        isError: false,
        isLoad: false,
        isSuccess: true,
        movies: r,
      );
    });
  }
}
