import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mymovieapp/Api_exception/api_exception.dart';
import 'package:mymovieapp/models/api.dart';
import 'package:mymovieapp/models/movie.dart';
import 'package:mymovieapp/providers/dio_provider.dart';

final searchserviceprovider =
    Provider((ref) => SearchService(ref.watch(dioProvider)));

class SearchService {
  final Dio _dio;
  SearchService(this._dio);

  Future<Either<String, List<Movie>>> getSearch({required String query}) async {
    try {
      final response = await _dio.get(Api.searchMovie, queryParameters: {
        'api_key': Api.apiKey,
        'query': query,
        'page': 1,
      });
      final extractdata = (response.data['results'] as List)
          .map((e) => Movie.fromJson(e))
          .toList();
      return (Right(extractdata));
    } on DioError catch (err) {
      return Left(DioException().getDioError(err));
    }
  }
}
