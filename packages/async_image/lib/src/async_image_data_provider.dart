import 'dart:typed_data';

import 'package:async_image/src/image_data_loader_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final asyncImageDataProvider =
    FutureProvider.autoDispose.family<Uint8List, String>((ref, imageUrl) async {
  final imageUri = Uri.parse(imageUrl);
  final loadOperation = ref.read(imageDataLoaderProvider).load(imageUri);
  ref.onDispose(loadOperation.cancel);
  return loadOperation.value;
});
