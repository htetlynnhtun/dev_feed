import 'dart:typed_data';
import 'package:async/async.dart';

abstract class ImageDataLoader {
  CancelableOperation<Uint8List> load(Uri url);
}
