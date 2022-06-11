// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:draw/draw.dart';
import 'package:flutter_assignment/states/hot_posts_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';

class MockHiveInterface extends Mock implements HiveInterface {}

class MockHiveBox extends Mock implements Box {}

class MockReddit extends Mock implements Reddit { }

void main() {
  MockHiveInterface mockHiveInterface;
  MockHiveBox mockHiveBox;
  MockReddit mockReddit;

  HotPostsState? hotPostsState;

  setUp(() {
    mockHiveInterface = MockHiveInterface();
    mockHiveBox = MockHiveBox();
    mockReddit = MockReddit();

    SubredditRef subredditRef = mockReddit.subreddit("FlutterDev");
    hotPostsState = HotPostsState(reddit: mockReddit, subredditRef: subredditRef);
  });

  test('load testing', () {
    verify(hotPostsState!.loadHotPosts());
  });
}
