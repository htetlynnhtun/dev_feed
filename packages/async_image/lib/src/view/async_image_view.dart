import 'package:async_image/src/async_image_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncImageView extends StatelessWidget {
  final String imageUrl;

  const AsyncImageView({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme(
      :secondary,
      :errorContainer,
      :onErrorContainer,
    ) = Theme.of(context).colorScheme;
    return Consumer(builder: (context, ref, child) {
      final imageData = ref.watch(asyncImageDataProvider(imageUrl));

      return switch (imageData) {
        AsyncData(:final value) => Image.memory(
            key: ValueKey(value),
            value,
            fit: BoxFit.cover,
          ),
        AsyncError() => ColoredBox(
            key: const ValueKey('async-image-failure-view'),
            color: errorContainer,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  key: const ValueKey('retry-button'),
                  onPressed: () {
                    ref.invalidate(asyncImageDataProvider(imageUrl));
                  },
                  icon: Icon(
                    Icons.refresh,
                    color: onErrorContainer,
                  ),
                ),
                const Text('Failed to load image'),
              ],
            ),
          ),
        _ => Center(
            child: CircularProgressIndicator(
              key: const ValueKey('async-image-loading-indicator'),
              color: secondary,
            ),
          ),
      };
    });
  }
}
