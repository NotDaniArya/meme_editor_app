import 'package:meme_editor_app/features/meme/domain/entities/meme.dart';

class MemeModel extends Meme {
  const MemeModel({required super.id, required super.name, required super.url});

  factory MemeModel.fromJson(Map<String, dynamic> json) {
    return MemeModel(id: json['id'], name: json['name'], url: json['url']);
  }
}
