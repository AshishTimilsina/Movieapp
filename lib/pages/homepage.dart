import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mymovieapp/pages/tab_bar_widget.dart';

import '../constants/enum.dart';

class Homeapp extends StatelessWidget {
  const Homeapp({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Watch Now',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        size: 25,
                      ))
                ],
              ),
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                text: Categorytype.popular.name,
              ),
              Tab(
                text: Categorytype.toprated.name,
              ),
              Tab(
                text: Categorytype.upcoming.name,
              ),
            ],
          ),
        ),
        body: const TabBarView(children: [
          TabBarWidget(
            category: Categorytype.popular,
          ),
          TabBarWidget(
            category: Categorytype.toprated,
          ),
          TabBarWidget(
            category: Categorytype.upcoming,
          ),
        ]),
      ),
    );
  }
}
