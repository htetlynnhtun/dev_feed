import 'package:async/async.dart';
import 'package:flutter/foundation.dart';

import 'package:dev_feed/feed/model/model.dart';

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
