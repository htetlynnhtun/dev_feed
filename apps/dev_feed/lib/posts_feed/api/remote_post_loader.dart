import 'package:dev_feed/posts_feed/model/model.dart';
import 'package:http/http.dart' as http;

final class RemotePostLoader implements PostLoader {
  final Uri url;
  final http.Client _client;
  final List<Post> Function(http.Response) mapper;
  RemotePostLoader(
      {required this.url, required http.Client client, required this.mapper})
      : _client = client;

  /// May throw [SocketException] or [FormatException]
  @override
  Future<List<Post>> load() async {
    final response = await _client.get(url);
    return mapper(response);
  }
}

