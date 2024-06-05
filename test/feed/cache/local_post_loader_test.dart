import 'package:dev_feed/feed/cache/cache.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'local_post_loader_test.mocks.dart';

@GenerateNiceMocks([MockSpec<PostStore>()])
void main() {
  group('LocalPostLoader:', () {
    test('does not message store on init', () {
      final mockedStore = MockPostStore();

      LocalPostLoader(postStore: mockedStore);

      verifyZeroInteractions(mockedStore);
    });

    test('load should trigger store retrieval', () {
      final mockedStore = MockPostStore();
      final sut = LocalPostLoader(postStore: mockedStore);

      sut.load();

      verify(mockedStore.retrieve()).called(1);
    });

    test('load fails on retrieval error', () {
      final mockedStore = MockPostStore();
      final sut = LocalPostLoader(postStore: mockedStore);
      final retrievalError = Exception('Retrieval error');
      when(mockedStore.retrieve()).thenThrow(retrievalError);

      expect(() => sut.load(), throwsA(retrievalError));
    });
  });
}
