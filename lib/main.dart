import 'dart:typed_data';

import 'package:async/async.dart';
import 'package:dev_feed/feed/cache/realm_image_data_store.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:realm/realm.dart';

import 'package:dev_feed/feed/api/api.dart';
import 'package:dev_feed/feed/api/remote_image_data_loader.dart';
import 'package:dev_feed/feed/cache/cache.dart';
import 'package:dev_feed/feed/model/model.dart';
import 'package:dev_feed/feed_ui_composer.dart';

void main() {
  final realmConfig = Configuration.local([
    RealmPost.schema,
    RealmUser.schema,
    RealmImageCache.schema,
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

  final imageDataStore = RealmImageDataStore(realm);

  final localImageDataLoader = LocalImageDataLoader(imageDataStore);

  final dio = Dio();

  final remoteImageDataLoader = RemoteImageDataLoader(dio);

  final imageDataLoaderComposite = ImageDataLoaderWithFallbackComposite(
    primary: localImageDataLoader,
    fallback: ImageDataLoaderCacheDecorator(
      decoratee: remoteImageDataLoader,
      cache: localImageDataLoader,
    ),
  );

  runApp(
    MainApp(
      home: FeedUIComposer.feedPage(
        postLoaderComposite,
        imageDataLoaderComposite,
      ),
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

final class ImageDataLoaderWithFallbackComposite implements ImageDataLoader {
  final ImageDataLoader primary;
  final ImageDataLoader fallback;

  ImageDataLoaderWithFallbackComposite({
    required this.primary,
    required this.fallback,
  });

  @override
  CancelableOperation<Uint8List> load(Uri url) {
    var loadOperation = primary.load(url);
    return CancelableOperation.fromFuture(
      () async {
        try {
          final data = await loadOperation.value;
          return data;
        } catch (_) {
          loadOperation = fallback.load(url);
          return loadOperation.value;
        }
      }(),
      onCancel: loadOperation.cancel,
    );
  }
}

final class ImageDataLoaderCacheDecorator implements ImageDataLoader {
  final ImageDataLoader decoratee;
  final ImageDataCache cache;

  ImageDataLoaderCacheDecorator({
    required this.decoratee,
    required this.cache,
  });

  @override
  CancelableOperation<Uint8List> load(Uri url) {
    final loadOperation = decoratee.load(url);
    return CancelableOperation.fromFuture(
      () async {
        final data = await loadOperation.value;
        await cache.save(data, url);
        return data;
      }(),
      onCancel: loadOperation.cancel,
    );
  }
}
