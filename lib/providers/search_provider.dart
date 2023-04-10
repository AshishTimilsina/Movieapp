import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mymovieapp/services/search_services.dart';
import 'package:mymovieapp/states/search_state.dart';

final searchprovider =
    StateNotifierProvider.autoDispose<SearchProvider, SearchState>((ref) =>
        SearchProvider(SearchState.empty(), ref.watch(searchserviceprovider)));

class SearchProvider extends StateNotifier<SearchState> {
  final SearchService services;
  SearchProvider(super.state, this.services);
  Future<void> getdata(String query) async {
    state = state.copyWith(
        isLoad: true,
        page: state.page,
        errMessage: '',
        isError: false,
        isSuccess: true);
    final getdata = await services.getSearch(query: query);
    getdata.fold((l) {
      state = state.copyWith(
        errMessage: l,
        isError: true,
        isLoad: false,
        isSuccess: false,
        movies: [],
        page: 1,
      );
    }, (r) {
      state = state.copyWith(
          errMessage: '',
          isError: false,
          isLoad: false,
          isSuccess: true,
          movies: r,
          page: 1);
    });
  }
}
