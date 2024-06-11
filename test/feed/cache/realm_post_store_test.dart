import 'package:dev_feed/feed/cache/cache.dart';
import 'package:realm/realm.dart';
import 'package:test/test.dart';

void main() {
  group('RealmPostStore', () {
    group('.retrieve()', () {
      test('delivers empty posts on empty cache', () async {
        final realm = Realm(Configuration.inMemory([
          RealmPost.schema,
          RealmUser.schema,
        ]));
        addTearDown(() => realm.close());
        final sut = RealmPostStore(realm: realm);

        final posts = await sut.retrieve();

        expect(posts.length, 0);
      });

      test('has no side effects on empty cache', () async {
        final realm = Realm(Configuration.inMemory([
          RealmPost.schema,
          RealmUser.schema,
        ]));
        addTearDown(() => realm.close());
        final sut = RealmPostStore(realm: realm);

        final firstPosts = await sut.retrieve();
        final lastPosts = await sut.retrieve();

        expect(firstPosts.length, 0);
        expect(lastPosts.length, 0);
      });
    });
  });
}
