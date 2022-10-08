import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'types.g.dart';

@HiveType(typeId: 0)
class SongTypes extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String artist;
  @HiveField(3)
  final String uri;
  int count;

  SongTypes(
      {required this.id,
      required this.title,
      required this.artist,
      required this.uri,
      this.count = 0});
}
