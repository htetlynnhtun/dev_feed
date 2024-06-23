import 'package:test/test.dart';

void main() {
  test('LocalBookmarkCreator does not message store on init', () {
    final storeSpy = BookmarkStoreSpy();
    final sut = LocalBookmarkCreator(storeSpy);
    expect(
      storeSpy.messages.isEmpty,
      true,
      reason: 'Expected not to send store any message',
    );
  });
}

class LocalBookmarkCreator {
  LocalBookmarkCreator(BookmarkStoreSpy store);
}

class BookmarkStoreSpy {
  final messages = [];
}
