import 'package:draw/draw.dart';

class RedditClientService {
  final Reddit reddit;

  RedditClientService(this.reddit);

  String _username = "";

  String get authUrl => reddit.auth.url(['*'], "testApp").toString();
  String get username => _username;

  factory RedditClientService.createInstalledFlow(String authCode) {
    final Reddit reddit = Reddit.createInstalledFlowInstance(
        clientId: '07uQvGpEfPp1Fc_qh3PZ7Q',
        userAgent: 'testApp',
        redirectUri: Uri.parse('testApp-auth://app.dev')
    );

    return RedditClientService(reddit);
  }

  Future<void> authorizeClient(String authCode) async {
    reddit.auth.url(['*'], "testApp");
    await reddit.auth.authorize(authCode);
    print(reddit.auth.credentials.toJson());
  }

  Future<void> setUsername() async {
    Redditor? redditor = await reddit.user.me();
    if (redditor != null) {
      _username = redditor.displayName;
    } else {
      _username = "";
    }
  }
}