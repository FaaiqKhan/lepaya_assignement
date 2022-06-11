import 'post.dart';

abstract class HiveServiceInterface {
  Future<List<Post>> getPosts(String postType);
  Future<void> setPosts(List<Post> data, String postType);
}