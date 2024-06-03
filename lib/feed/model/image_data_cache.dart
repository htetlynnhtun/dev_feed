
import 'dart:typed_data';

abstract class ImageDataCache {
  /// Saves the given image data associated with the specified url.
  /// 
  /// [data] The binary data of the image to save.
  /// [url] The url associated with the image data.
  Future<void> save(Uint8List data, Uri url);
}
