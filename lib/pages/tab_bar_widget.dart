import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mymovieapp/models/api.dart';
import 'package:mymovieapp/providers/movie_provider.dart';
import '../constants/enum.dart';

class TabBarWidget extends StatelessWidget {
  final Categorytype category;
  const TabBarWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final apiPath = category == Categorytype.popular
          ? Api.popularMovie
          : category == Categorytype.toprated
              ? Api.topRatedMovie
              : Api.upComingMovie;
      final moviedata = ref.watch(movieprovider(apiPath));
      print(moviedata.movies);
      return GridView.builder(
          itemCount: moviedata.movies.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5),
          itemBuilder: (context, int index) {
            return CachedNetworkImage(
                imageUrl: moviedata.movies[index].poster_path);
          });
    });
  }
}
