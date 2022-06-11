import 'package:flutter_assignment/models/post.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/hive_service_interface.dart';

class HiveService implements HiveServiceInterface {
  static final HiveService _singleton = HiveService._internal();

  factory HiveService() => _singleton;

  HiveService._internal();

  static Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(PostAdapter());
  }

  @override
  Future<List<Post>> getPosts(String postType) async {
    final postsBox = await Hive.openBox<Post>(postType);
    final data = postsBox.values.toList();
    await postsBox.close();
    return data;
  }

  @override
  Future<void> setPosts(List<Post> data, String postType) async {
    final postsBox = await Hive.openBox<Post>(postType);
    await postsBox.addAll(data);
    await postsBox.close();
  }

}