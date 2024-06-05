import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:dev_feed/async_image/model/image_data_loader.dart';

part 'async_image_view_model.freezed.dart';
part 'async_image_view_state.dart';

typedef AsyncImageViewModelFactory = AsyncImageViewModel Function(String url);

class AsyncImageViewModel extends ValueNotifier<AsyncImageViewState> {
  final String _imageURL;
  final ImageDataLoader _dataLoader;

  var _isDisposed = false;
  CancelableOperation<Uint8List>? _dataLoadingOperation;

  AsyncImageViewModel({
    required String imageURL,
    required ImageDataLoader dataLoader,
  })  : _imageURL = imageURL,
        _dataLoader = dataLoader,
        super(const AsyncImageViewState.loading());

  void load() async {
    value = const AsyncImageViewState.loading();
    try {
      _dataLoadingOperation = _dataLoader.load(Uri.parse(_imageURL));
      final imageData = await _dataLoadingOperation!.value;
      value = AsyncImageViewState.loaded(imageData);
    } on String catch (message) {
      value = AsyncImageViewState.failure(message);
    }
  }

  @override
  set value(AsyncImageViewState newValue) {
    if (_isDisposed) return;
    super.value = newValue;
  }

  @override
  void dispose() {
    _dataLoadingOperation?.cancel();
    _isDisposed = true;
    super.dispose();
  }
}
