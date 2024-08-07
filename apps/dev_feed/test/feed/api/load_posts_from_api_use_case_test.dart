import 'dart:convert';
import 'dart:io';

import 'package:dev_feed/posts_feed/api/posts_mapper.dart';
import 'package:dev_feed/posts_feed/model/model.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:dev_feed/posts_feed/api/api.dart';

import '../../helpers.dart';
import 'load_posts_from_api_use_case_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  (RemotePostLoader, MockClient) makeSUT({Uri? url}) {
    final mockClient = MockClient();
    return (
      RemotePostLoader(
        url: url ?? Uri.parse("https://default.com"),
        client: mockClient,
        mapper: PostsMapper.map,
      ),
      mockClient
    );
  }

  group('RemotePostLoader', () {
    test('load makes a GET request with correct url to http client', () {
      final url = Uri.parse('https://a-url.com');
      final (sut, mockClient) = makeSUT(url: url);

      when(mockClient.get(any))
          .thenAnswer((_) async => http.Response('[]', 200));
      sut.load();

      verify(mockClient.get(url)).called(1);
    });

    test('load throws a SocketException on network error', () {
      final (sut, mockClient) = makeSUT();

      when(mockClient.get(any)).thenThrow(
        const SocketException('Failed to connect'),
      );

      expect(sut.load(), throwsA(isA<SocketException>()));
    });

    test('load throws a FormatException on invalid JSON', () {
      final (sut, mockClient) = makeSUT();

      when(mockClient.get(any))
          .thenAnswer((_) async => http.Response('invalid JSON', 200));

      expect(sut.load(), throwsA(isA<FormatException>()));
    });

    test('load delivers a successfully parsed valid response', () async {
      final (sut, mockClient) = makeSUT();

      final post = makePost(id: 1);
      final postsData = [
        {
          'id': post.id,
          'title': post.title,
          'description': post.description,
          'tag_list': post.tagList,
          'reading_time_minutes': post.readingTimeMinutes,
          'published_at': post.publishedAt.toString(),
          'public_reactions_count': post.likeCount,
          'cover_image': post.coverImage,
          'user': {
            'name': post.user.name,
            'profile_image': post.user.profileImage,
          },
        }
      ];
      when(mockClient.get(any))
          .thenAnswer((_) async => http.Response(jsonEncode(postsData), 200));

      final posts = await sut.load();

      expect(posts, isA<List<Post>>());
      expect(posts.length, 1);
      expect(posts.first, equals(post));
    });
  });
}
