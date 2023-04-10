import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mymovieapp/constants/spinkit.dart';
import 'package:mymovieapp/providers/video_provider.dart';
import 'package:pod_player/pod_player.dart';
import '../models/movie.dart';
import '../services/recmd_movie_service.dart';
import 'detailPage_route.dart';

class DetailPage extends StatelessWidget {
  final Movie movie;
  const DetailPage(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, ref, child) {
        final videodata = ref.watch(videoprovider(movie.id));
        final rcmddata = ref.watch(rcmdprovider(movie.id));
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            videodata.when(
                data: (data) => data.isEmpty
                    ? const Center(
                        child: Text('There was a Problem Playing this video'))
                    : SizedBox(
                        height: 300,
                        child: PlayVideoFromNetwork(videokey: data)),
                error: ((error, stackTrace) => Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                          height: 300,
                          width: double.infinity,
                          child: Center(
                            child:
                                Text('There was a Problem Playing this video'),
                          )),
                    )),
                // hamro loading uta pod player batai aaune bhayekole loading lai empty rakxau
                loading: () => Container()),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                movie.title,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                movie.overview,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 19,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'You Might also like',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: SizedBox(
                height: 200,
                child: rcmddata.when(
                    data: (data) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            // shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: GestureDetector(
                                  onTap: () async {
                                    await Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return DProutepage(movie);
                                    }));
                                  },
                                  child: CachedNetworkImage(
                                      errorWidget: (context, url, error) =>
                                          const Image(
                                            image: AssetImage(
                                                'assets/images/popcorn.png'),
                                            width: 225,
                                            fit: BoxFit.cover,
                                          ),
                                      imageUrl: data[index].poster_path),
                                ),
                              );
                            }),
                      );
                    },
                    error: (err, _) {
                      return Text('$err');
                    },
                    loading: () => const Center(child: spinkit)),
              ),
            )
          ],
        );
      }),
    );
  }
}

class PlayVideoFromNetwork extends StatefulWidget {
  final String videokey;
  const PlayVideoFromNetwork({Key? key, required this.videokey})
      : super(key: key);
  @override
  State<PlayVideoFromNetwork> createState() => _PlayVideoFromNetworkState();
}

class _PlayVideoFromNetworkState extends State<PlayVideoFromNetwork> {
  late final PodPlayerController controller;

  @override
  void initState() {
    controller = PodPlayerController(
        playVideoFrom:
            PlayVideoFrom.youtube('https://youtu.be/${widget.videokey}'),
        podPlayerConfig: const PodPlayerConfig(
            autoPlay: true,
            isLooping: false,
            videoQualityPriority: [1080, 720, 360]))
      ..initialise();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PodVideoPlayer(controller: controller),
    );
  }
}
