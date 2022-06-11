import 'dart:async';

import 'package:draw/draw.dart';
import 'package:flutter/material.dart';

import '../models/post.dart';
import '../services/hive_service.dart';
import '../utils/key_utils.dart';
import '../utils/utils.dart';

class NewPostsState extends ChangeNotifier {
  final Reddit reddit;
  final SubredditRef subredditRef;

  final List<Post> _newPosts = [];

  bool _isLoading = false;

  NewPostsState({required this.reddit, required this.subredditRef});

  List<Post> get newPosts => List.from(_newPosts);
  bool get isLoading => _isLoading;

  void setNewPost(List<Post> posts) {
    _newPosts.addAll(posts);
    notifyListeners();
  }

  void setBusy({bool value = true}) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> loadNewPosts({int limit = 2, bool loadMore = false}) async {
    String? after = loadMore ? _newPosts.last.fullName : null;
    Stream<UserContent> newPostStream = subredditRef.newest(
      limit: limit,
      after: after,
    );
    final List<UserContent> userContents = await newPostStream.toList();
    final List<Post> newPosts = Utils.parseUserContentsToPosts(userContents);
    await HiveService().setPosts(newPosts, KeyUtils.newPost);
    _newPosts.addAll(newPosts);
    setBusy(value: false);
    notifyListeners();
  }
}
