import 'package:draw/draw.dart';
import 'package:flutter_assignment/states/hot_posts_state.dart';
import 'package:flutter_assignment/states/new_posts_state.dart';
import 'package:flutter_assignment/states/rising_posts_state.dart';

class PostsState {
  final Reddit reddit;

  late final SubredditRef _subredditRef;
  late final HotPostsState _hotPostsState;
  late final NewPostsState _newPostsState;
  late final RisingPostsState _risingPostsState;

  PostsState({required this.reddit}) {
    _subredditRef = reddit.subreddit("FlutterDev");

    _hotPostsState = HotPostsState(reddit: reddit, subredditRef: _subredditRef);
    _newPostsState = NewPostsState(reddit: reddit, subredditRef: _subredditRef);
    _risingPostsState = RisingPostsState(reddit: reddit, subredditRef: _subredditRef);
  }

  HotPostsState get hotPostsState => _hotPostsState;
  NewPostsState get newPostsState => _newPostsState;
  RisingPostsState get risingPostsState => _risingPostsState;
}
