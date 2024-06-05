import 'package:async/async.dart';
import 'package:flutter/foundation.dart';

import 'package:dev_feed/async_image/model/image_data_loader.dart';

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
      onCancel: () {
        loadOperation.cancel();
      },
    );
  }
}
