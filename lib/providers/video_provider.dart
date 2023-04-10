import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/api.dart';
import 'dio_provider.dart';

final videoprovider = FutureProvider.family(
    (ref, int id) => VideoProvider(ref.watch(dioProvider), id).getVideobyId());

class VideoProvider {
  final Dio _dio;
  final int id;
  VideoProvider(this._dio, this.id);

  Future<String> getVideobyId() async {
    try {
      final response = await _dio.get('/movie/$id/videos', queryParameters: {
        'api_key': Api.apiKey,
      });
      return (response.data['results'] as List)[0]['key'];
    } on DioError catch (err) {
      return err.toString();
    }
  }
}
