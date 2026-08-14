import 'package:isar/isar.dart';
part 'category.g.dart';

enum Categories {
  business,
  entertainment,
  general,
  health,
  science,
  sports,
  technology,
  food,
  travel,
  family,
  fashion,
  music,
  art,
  culture,
  history,
  education,
  utilities,
}

@collection
class Category {
  Id id = Isar.autoIncrement;
  late String type;
  late String name;
}
