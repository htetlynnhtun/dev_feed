import 'package:dev_feed/feed/cache/cache.dart';
import 'package:realm/realm.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  RealmPostStore makeSUT() {
    final realm = Realm(Configuration.inMemory([
      RealmPost.schema,
      RealmUser.schema,
    ]));
    addTearDown(() => realm.close());
    return RealmPostStore(realm: realm);
  }

  group('RealmPostStore', () {
    group('.retrieve()', () {
      test('delivers empty posts on empty cache', () async {
        RealmPostStore sut = makeSUT();

        final posts = await sut.retrieve();

        expect(posts.length, 0);
      });

      test('has no side effects on empty cache', () async {
        final sut = makeSUT();

        final firstPosts = await sut.retrieve();
        final lastPosts = await sut.retrieve();

        expect(firstPosts.length, 0);
        expect(lastPosts.length, 0);
      });

      test('delivers found posts on non-empty cache', () async {
        final sut = makeSUT();

        final insertedPosts = [
          makePost(id: 1),
          makePost(id: 2),
        ];
        await sut.insert(insertedPosts);
        final retrievedPosts = await sut.retrieve();

        expect(retrievedPosts, insertedPosts);
      });

      test('has no side effects on non-empty cache', () async {
        final sut = makeSUT();

        final insertedPosts = [
          makePost(id: 1),
          makePost(id: 2),
        ];
        await sut.insert(insertedPosts);
        final fistRetrievedPosts = await sut.retrieve();
        final lastRetrievedPosts = await sut.retrieve();

        expect(fistRetrievedPosts, insertedPosts);
        expect(lastRetrievedPosts, insertedPosts);
      });
    });
  });
}
