import 'package:flutter/material.dart';
import 'package:flutter_assignment/states/hot_posts_state.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/item_widget.dart';

class HotPostsScreen extends StatelessWidget {
  late final HotPostsState _provider;
  late final ScrollController _scrollController;

  HotPostsScreen(BuildContext context, {Key? key}) : super(key: key) {
    _scrollController = ScrollController()..addListener(loadData);
    _provider = Provider.of<HotPostsState>(context, listen: true);
  }

  void loadData() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _provider.setBusy(value: true);
      await _provider.loadHotPosts(loadMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final posts = _provider.hotPosts;
    return ListView.builder(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => launchUrl(Uri.parse(posts[index].url)),
          child: ItemWidget(posts[index].title, posts[index].content),
        );
      },
    );
  }
}
