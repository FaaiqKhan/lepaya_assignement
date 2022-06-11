import 'package:draw/draw.dart';

import '../models/post.dart';

class Utils {
  static List<Post> parseUserContentsToPosts(List<UserContent> userContents) {
    List<Post> posts = [];
    for (UserContent userContent in userContents) {
      Submission content = userContent as Submission;
      Post post = Post(
        id: content.id!,
        url: content.url.toString(),
        title: content.title,
        content: content.selftext!,
        fullName: content.fullname!,
      );
      posts.add(post);
    }
    return posts;
  }
}