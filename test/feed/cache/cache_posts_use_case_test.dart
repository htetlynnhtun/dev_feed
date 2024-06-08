import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:dev_feed/feed/cache/cache.dart';

import '../../helpers.dart';
import 'cache_posts_use_case_test.mocks.dart';

@GenerateNiceMocks([MockSpec<PostStore>()])
void main() {
  (MockPostStore, LocalPostLoader) makeSUT() {
    final mockedStore = MockPostStore();
    final sut = LocalPostLoader(postStore: mockedStore);
    return (mockedStore, sut);
  }

  group('LocalPostLoader', () {
    test('.new() does not message store', () {
      final (mockedStore, _) = makeSUT();

      verifyZeroInteractions(mockedStore);
    });

    test('.save() requests cache deletion', () async {
      final (mockedStore, sut) = makeSUT();

      await sut.save([makePost(id: 1)]);

      verify(mockedStore.deleteCachedPosts()).called(1);
    });

    test('.save() does not request cache insertion on deletion error',
        () async {
      final (mockedStore, sut) = makeSUT();
      when(mockedStore.deleteCachedPosts())
          .thenThrow(Exception('deletion error'));

      sut.save([makePost(id: 1)]).whenComplete(() {
        verify(mockedStore.deleteCachedPosts()).called(1);
        verify(mockedStore.insert(any)).called(0);
      }).ignore();
    });

    test('.save() requests new cache insertion on successful deletion',
        () async {
      final (mockedStore, sut) = makeSUT();
      final posts = [makePost(id: 1)];

      await sut.save(posts);

      verify(mockedStore.deleteCachedPosts()).called(1);
      verify(mockedStore.insert(posts)).called(1);
    });

    test('.save() fails on deletion error', () {
      final (mockedStore, sut) = makeSUT();
      final deletionError = Exception('deletion error');
      when(mockedStore.deleteCachedPosts()).thenThrow(deletionError);

      expect(
        sut.save([makePost(id: 1)]),
        throwsA((deletionError)),
      );
    });

    test('.save() fails on insertion error', () {
      final (mockedStore, sut) = makeSUT();
      final insertionError = Exception('Insertion error');
      when(mockedStore.insert(any)).thenThrow(insertionError);

      expect(
        sut.save([makePost(id: 1)]),
        throwsA((insertionError)),
      );
    });

    test('.save() succeeds on successful cache insertion', () async {
      final (_, sut) = makeSUT();

      try {
        await sut.save([makePost(id: 1)]);
      } catch (e) {
        fail('Expected to succeed, but found exception: $e');
      }
    });
  });
}
