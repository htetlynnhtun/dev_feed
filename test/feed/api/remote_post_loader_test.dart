import 'dart:convert';
import 'dart:io';

import 'package:dev_feed/feed/model/model.dart';
import 'package:dev_feed/shared/model/model.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:dev_feed/feed/api/api.dart';

import 'remote_post_loader_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  (RemotePostLoader, MockClient) makeSUT() {
    final mockClient = MockClient();
    return (RemotePostLoader(client: mockClient), mockClient);
  }

  group('RemotePostLoader', () {
    test('load requests a get request to http client', () {
      final (sut, mockClient) = makeSUT();

      when(mockClient.get(any))
          .thenAnswer((_) async => http.Response('[]', 200));
      sut.load();

      verify(mockClient.get(any)).called(1);
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

      final post = (
        id: 1,
        title: 'Test Post',
        description: 'A description',
        tagList: ['a', 'b', 'c'],
        readingTimeMinutes: 3,
        publishedAt: DateTime.now(),
        publicReactionsCount: 7,
        user: (
          name: 'Jane',
          profileImage: 'https://example.com/img.png',
        ),
      );
      final postsData = [
        {
          'id': post.id,
          'title': post.title,
          'description': post.description,
          'tag_list': post.tagList,
          'reading_time_minutes': post.readingTimeMinutes,
          'published_at': post.publishedAt.toString(),
          'public_reactions_count': post.publicReactionsCount,
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
      expect(
          posts.first,
          equals(Post(
            id: post.id,
            title: post.title,
            description: post.description,
            coverImage: null,
            tagList: post.tagList,
            readingTimeMinutes: post.readingTimeMinutes,
            publishedAt: post.publishedAt,
            likeCount: post.publicReactionsCount,
            user: User(
              name: post.user.name,
              profileImage: post.user.profileImage,
            ),
          )));
    });
  });
}
