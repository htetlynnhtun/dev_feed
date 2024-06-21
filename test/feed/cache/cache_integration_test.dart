import 'package:dev_feed/posts_feed/cache/cache.dart';
import 'package:realm/realm.dart';
import 'package:test/test.dart';

void main() {
  final realm = Realm(Configuration.local([
    RealmPost.schema,
    RealmUser.schema,
  ]));
  final realmPostStore = RealmPostStore(realm: realm);

  setUp(() async {
    await realmPostStore.deleteCachedPosts();
  });

  LocalPostLoader makeSUT() => LocalPostLoader(postStore: realmPostStore);

  group('LocalFeedLoader integrated with Realm', () {
    test('.load() delivers no items on empty cache', () async {
      final sut = makeSUT();

      final posts = await sut.load();

      expect(
        posts.isEmpty,
        true,
        reason: 'Expected no posts on empty cache',
      );
    });
  });
}
