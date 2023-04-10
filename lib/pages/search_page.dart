import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mymovieapp/providers/search_provider.dart';

import '../constants/spinkit.dart';
import 'detail_page.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  final searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer(builder: (context, ref, child) {
          final searchdata = ref.watch(searchprovider);
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  onFieldSubmitted: (val) {
                    ref.read(searchprovider.notifier).getdata(val.trim());
                    searchcontroller.clear();
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Search Movies',
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              searchdata.isLoad
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : searchdata.isError
                      ? Text(searchdata.errMessage)
                      : Expanded(
                          child: GridView.builder(
                              itemCount: searchdata.movies.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 2 / 4,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemBuilder: (context, int index) {
                                final movie = searchdata.movies[index];
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return DetailPage(movie);
                                        }));
                                      },
                                      child: CachedNetworkImage(
                                        errorWidget: (context, url, error) =>
                                            Image(
                                          image: AssetImage(
                                              'assets/images/popcorn.png'),
                                          height: 200,
                                        ),
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
                        )
            ],
          );
        }),
      ),
    );
  }
}
