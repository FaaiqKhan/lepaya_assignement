import 'dart:async';

import 'package:draw/draw.dart';
import 'package:flutter_assignment/services/hive_service.dart';
import 'package:flutter_assignment/states/posts_state.dart';

import '../utils/key_utils.dart';

class GlobalState {
  late final Reddit reddit;
  late final PostsState _postsState;

  Future<void> initApp() async {
    reddit = await Reddit.createScriptInstance(
      clientId: '',
      clientSecret: '',
      userAgent: '',
      username: '',
      password: '',
    );

    _postsState = PostsState(reddit: reddit);

    final hotPosts = await HiveService().getPosts(KeyUtils.hotPost);
    if (hotPosts.isEmpty) {
      _postsState.hotPostsState.loadHotPosts();
    } else {
      _postsState.hotPostsState.setHotPost(hotPosts);
    }

    final newPosts = await HiveService().getPosts(KeyUtils.newPost);
    if (newPosts.isEmpty) {
      _postsState.newPostsState.loadNewPosts();
    } else {
      _postsState.newPostsState.setNewPost(newPosts);
    }

    final risingPosts = await HiveService().getPosts(KeyUtils.risingPost);
    if (risingPosts.isEmpty) {
      _postsState.risingPostsState.loadRisingPosts();
    } else {
      _postsState.risingPostsState.setRisingPost(risingPosts);
    }
  }

  PostsState get postsState => _postsState;
}
