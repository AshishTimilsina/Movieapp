import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mymovieapp/models/movie.dart';

import '../models/api.dart';
import '../providers/dio_provider.dart';

final rcmdprovider = FutureProvider.family(
    (ref, int id) => RecommendedMovies(ref.watch(dioProvider)).getdata(id: id));

class RecommendedMovies {
  final Dio _dio;
  RecommendedMovies(this._dio);

  Future<List<Movie>> getdata({required int id}) async {
    try {
      final response =
          await _dio.get('/movie/$id/recommendations', queryParameters: {
        'api_key': Api.apiKey,
        'page': 1,
      });
      return (response.data['results'] as List)
          .map((e) => Movie.fromJson(e))
          .toList();
    } on DioError catch (_) {
      throw 'Something went wrong';
    }
  }
}
