import 'package:dev_feed/async_image/api/remote_image_data_loader.dart';
import 'package:dev_feed/async_image/cache/local_image_data_loader.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:realm/realm.dart' hide App;

import 'package:dev_feed/async_image/cache/realm_image_data_store.dart';
import 'package:dev_feed/feed/api/api.dart';
import 'package:dev_feed/feed/cache/cache.dart';
import 'package:dev_feed/feed/feed_ui_composer.dart';
import 'package:dev_feed/post_detail/api/remote_post_details_loader.dart';
import 'package:dev_feed/post_detail/post_detail_ui_composer.dart';
import 'package:dev_feed/util/image_data_loader_cache_decorator.dart';
import 'package:dev_feed/util/image_data_loader_with_fallback_composite.dart';
import 'package:dev_feed/util/post_loader_cache_decorator.dart';
import 'package:dev_feed/util/post_loader_with_fallback_composite.dart';

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
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      debugPrint('❔❔❔ Received reqeust for ${options.uri}');
      handler.next(options);
    },
    onResponse: (response, handler) {
      debugPrint('✅✅✅ Received response for ${response.realUri}');
      handler.next(response);
    },
    onError: (error, handler) {
      debugPrint(
          '❗️❗️❗️ Error for ${error.requestOptions.uri}: ${error.message}');
      handler.next(error);
    },
  ));

  final remoteImageDataLoader = RemoteImageDataLoader(dio);

  final imageDataLoaderComposite = ImageDataLoaderWithFallbackComposite(
    primary: localImageDataLoader,
    fallback: ImageDataLoaderCacheDecorator(
      decoratee: remoteImageDataLoader,
      cache: localImageDataLoader,
    ),
  );

  final postDetailsLoader = RemotePostDetailsLoader(dio: dio);

  final router = GoRouter(
    initialLocation: '/posts',
    routes: [
      GoRoute(
        path: '/posts',
        builder: (context, state) => FeedUIComposer.feedPage(
          postLoaderComposite,
          imageDataLoaderComposite,
          (id) => context.go('/posts/$id'),
        ),
        routes: [
          GoRoute(
            path: ':postId',
            builder: (context, state) {
              final postId = int.parse(state.pathParameters['postId']!);
              return PostDetailUIComposer.detailPage(
                postId,
                postDetailsLoader,
                imageDataLoaderComposite,
              );
            },
          ),
        ],
      ),
    ],
    debugLogDiagnostics: kDebugMode,
  );

  runApp(
    MaterialApp.router(
      routerConfig: router,
    ),
  );
}
