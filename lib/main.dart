import 'package:flutter/material.dart';
import 'package:flutter_assignment/states/hot_posts_state.dart';
import 'package:flutter_assignment/states/new_posts_state.dart';
import 'package:flutter_assignment/states/rising_posts_state.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';
import 'services/hive_service.dart';
import 'states/global_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GlobalState globalState = GlobalState();

  await HiveService.initHive();

  await globalState.initApp();

  runApp(MyApp(
    globalState: globalState,
  ));
}

class MyApp extends StatelessWidget {
  final GlobalState globalState;

  const MyApp({Key? key, required this.globalState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HotPostsState>.value(
          value: globalState.postsState.hotPostsState,
        ),
        ChangeNotifierProvider<NewPostsState>.value(
          value: globalState.postsState.newPostsState,
        ),
        ChangeNotifierProvider<RisingPostsState>.value(
          value: globalState.postsState.risingPostsState,
        )
      ],
      child: MaterialApp(
        title: 'Lepaya Assignment',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontFamily: 'Lato-Bold',
              color: Colors.black,
              overflow: TextOverflow.ellipsis,
              fontSize: 14,
            ),
            bodyText1: TextStyle(
              fontFamily: 'Lato-Regular',
              color: Colors.black,
              overflow: TextOverflow.ellipsis,
              fontSize: 14,
            ),
          ),
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Lepaya Assignment'),
          ),
          body: const HomeScreen(),
        ),
      ),
    );
  }
}
