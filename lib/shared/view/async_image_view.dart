import 'package:dev_feed/shared/viewmodel/async_image_view_model.dart';
import 'package:flutter/material.dart';

class AsyncImageView extends StatefulWidget {
  final String imageUrl;
  final AsyncImageViewModelFactory viewModelFactory;

  const AsyncImageView({
    super.key,
    required this.imageUrl,
    required this.viewModelFactory,
  });

  @override
  State<AsyncImageView> createState() => _AsyncImageWidgetState();
}

class _AsyncImageWidgetState extends State<AsyncImageView> {
  late final AsyncImageViewModel _viewModel;
  @override
  void initState() {
    super.initState();
    _viewModel = widget.viewModelFactory(widget.imageUrl);
    _viewModel.load();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _viewModel,
      builder: (context, state, child) {
        final ColorScheme(
          :secondary,
          :errorContainer,
          :onErrorContainer,
        ) = Theme.of(context).colorScheme;

        return switch (state) {
          Loading() => Center(
              child: CircularProgressIndicator(
                color: secondary,
              ),
            ),
          Loaded(data: var bytes) => Image.memory(
              bytes,
              fit: BoxFit.cover,
            ),
          Failure(message: var message) => ColoredBox(
              color: errorContainer,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: _viewModel.load,
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
