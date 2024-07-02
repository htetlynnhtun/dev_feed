import 'dart:typed_data';

import 'package:async/async.dart';
import 'package:async_image/src/model/image_data_loader.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'async_image_view.freezed.dart';

class AsyncImageView extends StatefulWidget {
  final String imageUrl;
  final ImageDataLoader dataLoader;

  const AsyncImageView({
    super.key,
    required this.imageUrl,
    required this.dataLoader,
  });

  @override
  State<AsyncImageView> createState() => AsyncImageViewState();
}

class AsyncImageViewState extends State<AsyncImageView> {
  var value = const AsyncImageViewStateValue.loading();
  CancelableOperation<Uint8List>? _dataLoadingOperation;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    setState(() {
      value = const AsyncImageViewStateValue.loading();
    });
    try {
      _dataLoadingOperation =
          widget.dataLoader.load(Uri.parse(widget.imageUrl));
      final imageData = await _dataLoadingOperation!.value;
      setState(() {
        value = AsyncImageViewStateValue.loaded(imageData);
      });
    } catch (e) {
      setState(() {
        value = AsyncImageViewStateValue.failure(e.toString());
      });
    }
  }

  @override
  void dispose() {
    _dataLoadingOperation?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme(
      :secondary,
      :errorContainer,
      :onErrorContainer,
    ) = Theme.of(context).colorScheme;
    return switch (value) {
      Loading()  => Center(
          child: CircularProgressIndicator(
            key: const ValueKey('async-image-loading-indicator'),
            color: secondary,
          ),
        ),
      Loaded(data: var bytes) => Image.memory(
          key: ValueKey(bytes),
          bytes,
          fit: BoxFit.cover,
        ),
      Failure(message: var message) => ColoredBox(
          key: const ValueKey('async-image-failure-view'),
          color: errorContainer,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                key: const ValueKey('retry-button'),
                onPressed: load,
                icon: Icon(
                  Icons.refresh,
                  color: onErrorContainer,
                ),
              ),
              Text(message),
            ],
          ),
        ),
    };
  }
}

@freezed
sealed class AsyncImageViewStateValue with _$AsyncImageViewStateValue {
  const factory AsyncImageViewStateValue.loading() = Loading;
  const factory AsyncImageViewStateValue.loaded(Uint8List data) = Loaded;
  const factory AsyncImageViewStateValue.failure(String message) = Failure;
}
