import 'package:async/async.dart';
import 'package:async_image/async_image.dart';
import 'package:flutter/foundation.dart';

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
