import 'dart:io';

import 'package:realm/realm.dart';
import 'package:test/test.dart';

import 'package:dev_feed/posts_feed/cache/cache.dart';

import '../../helpers.dart';

void main() {
  Configuration.defaultRealmName = generateRandomRealmName();
  final realm = Realm(Configuration.local([
    RealmPost.schema,
    RealmUser.schema,
  ]));
  final realmPostStore = RealmPostStore(realm: realm);

  setUp(() async {
    await realmPostStore.deleteCachedPosts();
  });

  tearDown(() {
    realm.close();
    Realm.deleteRealm(realm.config.path);
    final realmDirectory = Directory(realm.config.path).parent;
    realmDirectory
        .listSync()
        .where((file) => file.path.endsWith('realm.lock'))
        .forEach((file) => file.deleteSync());
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
