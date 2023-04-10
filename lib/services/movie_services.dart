import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:mymovieapp/Api_exception/api_exception.dart';
import 'package:mymovieapp/models/api.dart';
import 'package:mymovieapp/providers/dio_provider.dart';

import '../models/movie.dart';

final movieserviceProvider =
    Provider((ref) => MovieService(ref.watch(dioProvider)));

class MovieService {
  final Dio _dio;
  MovieService(this._dio);
  final box = Hive.box<String>('movie');

  Future<Either<String, List<Movie>>> getdata(
      {required String apiPath, required int page}) async {
    try {
      final response = await _dio.get(apiPath, queryParameters: {
        'api_key': Api.apiKey,
        'page': page,
      });

      if (apiPath == Api.popularMovie) {
        final res = await _dio.get(apiPath, queryParameters: {
          'api_key': Api.apiKey,
          'page': 1,
        });

        box.put('popular', jsonEncode(res.data['results']));
      }

      final extractdata = (response.data['results'] as List)
          .map((e) => Movie.fromJson(e))
          .toList();
      return Right(extractdata);
    } on DioError catch (err) {
      // Hamile cache data dekhaune nai internet nabhako bela ho tesaile error ma hive pass gareko ho.
      if (box.isNotEmpty && apiPath == Api.popularMovie) {
        final data = jsonDecode(box.get('popular')!);

        final extractdata =
            (data as List).map((e) => Movie.fromJson(e)).toList();
        return Right(extractdata);
      } else {
        return Left(DioException().getDioError(err));
      }
    }
  }
}
