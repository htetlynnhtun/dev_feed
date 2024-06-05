import 'dart:typed_data';

abstract class ImageDataStore {
  Future<Uint8List?> retrieve(Uri url);
  Future<void> insert(Uint8List data, Uri url);
}
