import 'package:flutter/material.dart';
import 'package:mymovieapp/pages/search_page.dart';
import 'package:mymovieapp/pages/tab_bar_widget.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../constants/enum.dart';

class Homeapp extends StatelessWidget {
  const Homeapp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Watch Now',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SearchPage();
                        }));
                      },
                      icon: const Icon(
                        Icons.search,
                        size: 30,
                      ))
                ],
              ),
            ),
          ),
          bottom: TabBar(
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.pink; //<-- SEE HERE
                }
                return null;
              },
            ),
            splashBorderRadius: BorderRadius.circular(15),
            indicatorColor: Colors.black.withOpacity(0),
            tabs: [
              Tab(
                child: Text(
                  Categorytype.popular.name,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  Categorytype.toprated.name,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  Categorytype.upcoming.name,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(children: [
          TabBarWidget(
            category: Categorytype.popular,
            pagekey: 'popular',
          ),
          TabBarWidget(
            category: Categorytype.toprated,
            pagekey: 'toprated',
          ),
          TabBarWidget(
            category: Categorytype.upcoming,
            pagekey: 'upcoming',
          ),
        ]),
      ),
    );
  }
}
