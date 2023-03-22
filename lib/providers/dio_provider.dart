import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/api.dart';

final dioProvider = Provider((ref) {
  final options = BaseOptions(
    baseUrl: Api.baseUrl,
  );
  return Dio(options);
});
