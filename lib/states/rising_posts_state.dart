import 'dart:async';

import 'package:draw/draw.dart';
import 'package:flutter/material.dart';

import '../models/post.dart';
import '../services/hive_service.dart';
import '../utils/key_utils.dart';
import '../utils/utils.dart';

class RisingPostsState extends ChangeNotifier {
  final Reddit reddit;
  final SubredditRef subredditRef;

  final List<Post> _risingPosts = [];

  bool _isLoading = false;

  RisingPostsState({required this.reddit, required this.subredditRef});

  List<Post> get risingPosts => List.from(_risingPosts);
  bool get isLoading => _isLoading;

  void setRisingPost(List<Post> posts) {
    _risingPosts.addAll(posts);
    notifyListeners();
  }

  void setBusy({bool value = true}) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> loadRisingPosts({int limit = 2, bool loadMore = false}) async {
    String? after = loadMore ? _risingPosts.last.fullName : null;
    Stream<UserContent> risingPostStream = subredditRef.rising(
      limit: limit,
      after: after,
    );
    final List<UserContent> userContents = await risingPostStream.toList();
    final List<Post> risingPost = Utils.parseUserContentsToPosts(userContents);
    await HiveService().setPosts(risingPost, KeyUtils.risingPost);
    _risingPosts.addAll(risingPost);
    setBusy(value: false);
    notifyListeners();
  }
}
