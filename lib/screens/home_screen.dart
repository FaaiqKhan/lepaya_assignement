import 'package:flutter/material.dart';
import 'package:flutter_assignment/screens/hot_posts_screen.dart';
import 'package:flutter_assignment/screens/new_posts_screen.dart';
import 'package:flutter_assignment/screens/rising_posts_screen.dart';
import 'package:flutter_assignment/states/hot_posts_state.dart';
import 'package:flutter_assignment/states/new_posts_state.dart';
import 'package:flutter_assignment/states/rising_posts_state.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          bottom: const TabBar(
            tabs: [
              Tab(text: "Hot"),
              Tab(text: "New"),
              Tab(text: "Rising"),
            ],
          ),
        ),
        body: SafeArea(
          child: Consumer3<HotPostsState, NewPostsState, RisingPostsState>(
            builder: (context, posts1, posts2, posts3, child) {
              return Column(
                children: [
                  child!,
                  if (posts1.isLoading || posts2.isLoading || posts3.isLoading)
                    const CircularProgressIndicator()
                ],
              );
            },
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10.0),
                child: TabBarView(
                  children: [
                    HotPostsScreen(context),
                    NewPostsScreen(context),
                    RisingPostsScreen(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
