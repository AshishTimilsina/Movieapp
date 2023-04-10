import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mymovieapp/models/api.dart';
import 'package:mymovieapp/pages/detail_page.dart';
import 'package:mymovieapp/providers/movie_provider.dart';
import '../constants/enum.dart';
import '../constants/flutter_toast.dart';
import '../constants/spinkit.dart';
import 'package:flutter_offline/flutter_offline.dart';

class TabBarWidget extends StatelessWidget {
  final Categorytype category;
  final String pagekey;
  const TabBarWidget(
      {super.key, required this.category, required this.pagekey});

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
        child: Container(),
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          return connected
              ? _buildconsumer(connected)
              : category == Categorytype.popular
                  ? _buildconsumer(connected)
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [Text('No Internet')],
                    );
        });
  }

  Consumer _buildconsumer(bool connected) {
    return Consumer(builder: (context, ref, child) {
      final apiPath = category == Categorytype.popular
          ? Api.popularMovie
          : category == Categorytype.toprated
              ? Api.topRatedMovie
              : Api.upComingMovie;
      final moviedata = ref.watch(movieprovider(apiPath));
      if (moviedata.isLoad) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (moviedata.isError) {
        return Center(
          child: Text(moviedata.errMessage),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: NotificationListener(
            onNotification: (ScrollEndNotification onNotification) {
              final before = onNotification.metrics.extentBefore;
              final max = onNotification.metrics.maxScrollExtent;
              if (before == max) {
                if (connected) {
                  ref.read(movieprovider(apiPath).notifier).loadmore();
                }
              }
              return true;
            },
            child: GridView.builder(
                key: PageStorageKey<String>(pagekey),
                itemCount: moviedata.movies.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, int index) {
                  final movie = moviedata.movies[index];
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          if (connected) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return DetailPage(movie);
                            }));
                          } else {
                            return IsSuccess().fluttertoast();
                          }
                        },
                        child: CachedNetworkImage(
                          errorWidget: (context, url, error) => Image(
                              image: AssetImage('assets/images/popcorn.png')),
                          imageUrl: movie.poster_path,
                          placeholder: (context, url) => spinkit,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 50,
                        child: Text(
                          movie.title,
                          maxLines: 2,
                          style: const TextStyle(fontSize: 20),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  );
                }),
          ),
        );
      }
    });
  }
}
