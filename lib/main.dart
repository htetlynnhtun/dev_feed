import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:realm/realm.dart';

import 'package:dev_feed/feed/api/api.dart';
import 'package:dev_feed/feed/cache/cache.dart';
import 'package:dev_feed/feed/model/model.dart';
import 'package:dev_feed/feed_ui_composer.dart';

void main() {
  final realmConfig = Configuration.local([
    RealmPost.schema,
    RealmUser.schema,
  ]);
  final realm = Realm(realmConfig);

  final httpClient = http.Client();

  final remotePostLoader = RemotePostLoader(client: httpClient);

  final postStore = RealmPostStore(realm: realm);

  final localPostLoader = LocalPostLoader(postStore: postStore);

  final postLoaderComposite = PostLoaderWithFallbackComposite(
    primary: PostLoaderCacheDecorator(
      decoratee: remotePostLoader,
      cache: localPostLoader,
    ),
    fallback: localPostLoader,
  );

  runApp(
    MainApp(
      home: FeedUIComposer.feedPage(postLoaderComposite),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
    required this.home,
  });
  final Widget home;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: home);
  }
}

final class PostLoaderWithFallbackComposite implements PostLoader {
  final PostLoader primary;
  final PostLoader fallback;

  PostLoaderWithFallbackComposite({
    required this.primary,
    required this.fallback,
  });

  @override
  Future<List<Post>> load() async {
    try {
      final posts = await primary.load();
      return posts;
    } catch (_) {
      return fallback.load();
    }
  }
}

final class PostLoaderCacheDecorator implements PostLoader {
  final PostLoader decoratee;
  final PostCache cache;

  PostLoaderCacheDecorator({
    required this.decoratee,
    required this.cache,
  });

  @override
  Future<List<Post>> load() async {
    final posts = await decoratee.load();
    await cache.save(posts);
    return posts;
  }
}
