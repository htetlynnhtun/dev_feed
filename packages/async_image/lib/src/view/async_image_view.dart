import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'async_image_view.freezed.dart';

class AsyncImageView extends StatefulWidget {
  final String imageUrl;
  final Stream<Uint8List> Function(Uri) dataLoader;

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
  StreamSubscription<Uint8List>? _subscription;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    setState(() {
      value = const AsyncImageViewStateValue.loading();
    });
    final imageUri = Uri.parse(widget.imageUrl);
    _subscription = widget.dataLoader(imageUri).listen(
      (data) {
        setState(() {
          value = AsyncImageViewStateValue.loaded(data);
        });
      },
      onError: (e) {
        setState(() {
          value =
              const AsyncImageViewStateValue.failure('Failed to load image');
        });
      },
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
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
      Loading() => Center(
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
