import 'package:async_image/src/bloc/async_image_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AsyncImageView extends StatelessWidget {
  const AsyncImageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme(
      :secondary,
      :errorContainer,
      :onErrorContainer,
    ) = Theme.of(context).colorScheme;
    return BlocBuilder<AsyncImageCubit, AsyncImageState>(
      builder: (context, state) {
        return switch (state) {
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
                    onPressed: context.read<AsyncImageCubit>().load,
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
      },
    );
  }
}
