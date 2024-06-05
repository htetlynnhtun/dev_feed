import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:dev_feed/feed/cache/cache.dart';
import 'package:dev_feed/feed/model/model.dart';

import '../../helpers.dart';
import 'local_post_loader_test.mocks.dart';

@GenerateNiceMocks([MockSpec<PostStore>()])
void main() {
  (MockPostStore, LocalPostLoader) makeSUT() {
    final mockedStore = MockPostStore();
    final sut = LocalPostLoader(postStore: mockedStore);
    return (mockedStore, sut);
  }

  group('LocalPostLoader:', () {
    test('does not message store on init', () {
      final mockedStore = MockPostStore();

      LocalPostLoader(postStore: mockedStore);

      verifyZeroInteractions(mockedStore);
    });

    test('load should trigger store retrieval', () {
      final (mockedStore, sut) = makeSUT();
      sut.load();

      verify(mockedStore.retrieve()).called(1);
    });

    test('load fails on retrieval error', () {
      final (mockedStore, sut) = makeSUT();
      final retrievalError = Exception('Retrieval error');
      when(mockedStore.retrieve()).thenThrow(retrievalError);

      expect(() => sut.load(), throwsA(retrievalError));
    });

    test('load delivers no posts on empty cache', () {
      final (mockedStore, sut) = makeSUT();
      final emptyPosts = <Post>[];
      when(mockedStore.retrieve()).thenAnswer((_) async => emptyPosts);

      expect(sut.load(), completion(emptyPosts));
    });

    test('load delivers cached posts on retrieval success', () {
      final (mockedStore, sut) = makeSUT();
      final posts = [
        makePost(id: 1),
        makePost(id: 2),
      ];
      when(mockedStore.retrieve()).thenAnswer((_) async => posts);

      expect(sut.load(), completion(posts));
    });
  });
}
