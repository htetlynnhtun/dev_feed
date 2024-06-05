import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:dev_feed/feed/cache/cache.dart';
import 'package:dev_feed/feed/model/model.dart';

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
  });
}
