import 'package:async_image/async_image.dart';
import 'package:async_image/src/image_data_loader_cache_decorator.dart';
import 'package:async_image/src/image_data_loader_with_fallback_composite.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realm/realm.dart';

final realmProvider = Provider((ref) {
  final realmConfig = Configuration.local([
    RealmImageCache.schema,
  ]);
  return Realm(realmConfig);
});

final imageDataLoaderProvider = Provider<ImageDataLoader>((ref) {
  final localImageDataLoader = LocalImageDataLoader(
    RealmImageDataStore(ref.read(realmProvider)),
  );
  return ImageDataLoaderWithFallbackComposite(
    primary: localImageDataLoader,
    fallback: ImageDataLoaderCacheDecorator(
      decoratee: RemoteImageDataLoader(Dio()
        ..interceptors.add(InterceptorsWrapper(
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
        ))),
      cache: localImageDataLoader,
    ),
  );
});
