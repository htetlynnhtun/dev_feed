import 'package:freezed_annotation/freezed_annotation.dart';

part 'posts_endpoint.freezed.dart';

@freezed
sealed class PostsEndpoint with _$PostsEndpoint {
  const PostsEndpoint._();
  const factory PostsEndpoint.get(int page) = Get;
  const factory PostsEndpoint.getOne(int id) = GetOne;

  Uri url(String baseURL) {
    return switch (this) {
      Get(page: var page) =>
        Uri.parse('$baseURL/articles?per_page=20&page=$page'),
      GetOne(id: var id) => Uri.parse('$baseURL/articles/$id'),
    };
  }
}
