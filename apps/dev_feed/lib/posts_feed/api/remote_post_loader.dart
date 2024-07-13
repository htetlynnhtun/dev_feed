import 'dart:convert';

import 'package:dev_feed/posts_feed/model/model.dart';
import 'package:http/http.dart' as http;

final class RemotePostLoader implements PostLoader {
  final http.Client _client;
  final Uri url;

  RemotePostLoader({
    required http.Client client,
    required this.url,
  }) : _client = client;

  /// May throw [SocketException] or [FormatException]
  @override
  Future<List<Post>> load() async {
    final response = await _client.get(url);
    final parsed = (jsonDecode(response.body) as List).cast<JsonData>();
    return parsed.map((json) => Post.fromJson(json)).toList();
  }
}

typedef JsonData = Map<String, dynamic>;
