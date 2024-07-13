import 'dart:convert';
import 'package:dev_feed/posts_feed/model/model.dart';
import 'package:http/http.dart' as http;

abstract class PostsMapper {
  static List<Post> map(http.Response response) {
    switch (response.statusCode) {
      case 200:
        final parsed = (jsonDecode(response.body) as List).cast<JsonData>();
        return parsed.map((json) => Post.fromJson(json)).toList();
      default:
        throw 'Invalid data';
    }
  }
}

typedef JsonData = Map<String, dynamic>;
