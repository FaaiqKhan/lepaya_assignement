import 'dart:async';

import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/services/hive_service.dart';
import 'package:flutter_assignment/utils/key_utils.dart';
import 'package:flutter_assignment/utils/utils.dart';

import '../models/post.dart';

class HotPostsState extends ChangeNotifier {
  final Reddit reddit;
  final SubredditRef subredditRef;

  final List<Post> _hotPosts = [];

  bool _isLoading = false;

  HotPostsState({required this.reddit, required this.subredditRef});

  List<Post> get hotPosts => List.from(_hotPosts);

  bool get isLoading => _isLoading;

  void setHotPost(List<Post> posts) {
    _hotPosts.addAll(posts);
    notifyListeners();
  }

  void setBusy({bool value = true}) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> loadHotPosts({int limit = 2, bool loadMore = false}) async {
    String? after = loadMore ? _hotPosts.last.fullName : null;
    Stream<UserContent> hotPostStream = subredditRef.hot(
      limit: limit,
      after: after,
    );
    final List<UserContent> userContents = await hotPostStream.toList();
    final List<Post> hotPosts = Utils.parseUserContentsToPosts(userContents);
    await HiveService().setPosts(hotPosts, KeyUtils.hotPost);
    _hotPosts.addAll(hotPosts);
    setBusy(value: false);
    notifyListeners();
  }
}
