import 'package:async/async.dart';
import 'package:flutter/foundation.dart';

import 'package:dev_feed/async_image/model/image_data_cache.dart';
import 'package:dev_feed/async_image/model/image_data_loader.dart';

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
