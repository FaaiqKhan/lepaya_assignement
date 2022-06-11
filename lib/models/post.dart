import 'package:hive_flutter/hive_flutter.dart';

part 'post.g.dart';

@HiveType(typeId: 0)
class Post extends HiveObject {
  @HiveField(0)
  late final String id;
  @HiveField(1)
  late final String url;
  @HiveField(2)
  late final String title;
  @HiveField(3)
  late final String content;
  @HiveField(4)
  final String? fullName;

  Post({
    required this.id,
    required this.url,
    required this.title,
    required this.content,
    required this.fullName,
  });
}
