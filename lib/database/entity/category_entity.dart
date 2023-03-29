import 'package:floor/floor.dart';

@entity
class CategoryEntity {
  CategoryEntity({
    this.id,
    required this.name,
  });

  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;

  factory CategoryEntity.fromJson(Map<String, dynamic> json) {
    return CategoryEntity(name: json["name"] as String);
  }
}
