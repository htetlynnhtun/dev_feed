import 'package:dev_feed/feed/cache/cache.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'local_post_loader_test.mocks.dart';

@GenerateMocks([PostStore])
void main() {
  group('LocalPostLoader', () {
    test('does not message store on init', () {
      final mockedStore = MockPostStore();

      LocalPostLoader(postStore: mockedStore);

      verifyNoMoreInteractions(mockedStore);
    });
  });
}
