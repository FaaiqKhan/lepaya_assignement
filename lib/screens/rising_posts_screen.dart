import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../states/rising_posts_state.dart';
import '../widgets/item_widget.dart';

class RisingPostsScreen extends StatelessWidget {
  late final RisingPostsState _provider;
  late final ScrollController _scrollController;

  RisingPostsScreen(BuildContext context, {Key? key}) : super(key: key) {
    _scrollController = ScrollController()..addListener(loadData);
    _provider = Provider.of<RisingPostsState>(context, listen: true);
  }

  void loadData() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _provider.setBusy(value: true);
      await _provider.loadRisingPosts(loadMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final posts = _provider.risingPosts;
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