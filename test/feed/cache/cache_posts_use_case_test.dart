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

  group('LocalPostLoader:', () {
    test('does not message store on init', () {
      final (mockedStore, _) = makeSUT();

      verifyZeroInteractions(mockedStore);
    });

    test('save requests cache deletion', () {
      final (mockedStore, sut) = makeSUT();

      sut.save([makePost(id: 1)]);

      verify(mockedStore.deleteCachedPosts()).called(1);
    });
  });
}
