import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mymovieapp/models/api.dart';
import 'package:mymovieapp/providers/dio_provider.dart';

import '../models/movie.dart';

final movieserviceProvider =
    Provider((ref) => MovieService(ref.watch(dioProvider)));

class MovieService {
  final Dio _dio;
  MovieService(this._dio);

  Future<Either<String, List<Movie>>> getdata(
      {required String apiPath, required int page}) async {
    try {
      final response = await _dio.get(apiPath, queryParameters: {
        'api_key': Api.apiKey,
        'page': page,
      });

      final extractdata = (response.data['results'] as List)
          .map((e) => Movie.fromJson(e))
          .toList();
      return Right(extractdata);
    } on DioError catch (err) {
      return Left(err.toString());
    }
  }
}
