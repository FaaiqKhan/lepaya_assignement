import 'package:draw/draw.dart';

class RedditClient {
  static final RedditClient _singleton = RedditClient._internal();
  static final Reddit reddit = Reddit.createInstalledFlowInstance(
    clientId: '07uQvGpEfPp1Fc_qh3PZ7Q',
    userAgent: 'testApp',
    redirectUri: Uri.parse('testApp-auth://app.dev')
  );
  static final authUrl = reddit.auth.url(['*'], "testApp");

  factory RedditClient() {
    return _singleton;
  }

  RedditClient._internal();
}