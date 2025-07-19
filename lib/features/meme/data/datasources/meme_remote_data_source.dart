import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meme_editor_app/core/error/exceptions.dart';
import 'package:meme_editor_app/features/meme/data/models/meme_models.dart';

abstract class MemeRemoteDataSource {
  Future<List<MemeModel>> getMemes();
}

class MemeRemoteDataSourceImpl implements MemeRemoteDataSource {
  final http.Client client;
  MemeRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MemeModel>> getMemes() async {
    final res = await client.get(
      Uri.parse('https://api.imgflip.com/get_memes'),
      headers: {'Content-Type': 'application/json'},
    );

    if (res.statusCode == 200) {
      final data = json.decode(res.body)['data']['memes'] as List;
      return data.map((item) => MemeModel.fromJson(item)).toList();
    } else {
      throw ServerException();
    }
  }
}
