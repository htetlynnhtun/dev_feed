import 'dart:typed_data';

import 'package:async/async.dart';
import 'package:dev_feed/async_image/cache/image_data_store.dart';
import 'package:dev_feed/async_image/model/image_data_cache.dart';
import 'package:dev_feed/async_image/model/image_data_loader.dart';

final class LocalImageDataLoader implements ImageDataLoader, ImageDataCache {
  final ImageDataStore store;

  LocalImageDataLoader(this.store);

  @override
  CancelableOperation<Uint8List> load(Uri url) {
    return CancelableOperation.fromFuture(() async {
      final data = await store.retrieve(url);
      if (data == null) {
        throw ImageDataNotFoundException();
      }
      return data;
    }());
  }

  @override
  Future<void> save(Uint8List data, Uri url) {
    return store.insert(data, url);
  }
}

sealed class ImageLoadException implements Exception {}

final class ImageDataNotFoundException extends ImageLoadException {}
