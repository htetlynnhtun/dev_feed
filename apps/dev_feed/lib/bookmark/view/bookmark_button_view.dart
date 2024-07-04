import 'package:dev_feed/bookmark/viewmodel/bookmark_item_view_model.dart';
import 'package:flutter/material.dart';

class BookmarkButtonView extends StatefulWidget {
  final BookmarkItemViewModel Function() viewModelFactory;

  const BookmarkButtonView({
    super.key,
    required this.viewModelFactory,
  });

  @override
  State<BookmarkButtonView> createState() => _BookmarkButtonViewState();
}

class _BookmarkButtonViewState extends State<BookmarkButtonView> {
  late final BookmarkItemViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = widget.viewModelFactory();
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
      builder: (context, isBookmarked, child) {
        final icon = isBookmarked
            ? Icons.bookmark //
            : Icons.bookmark_outline;
        return IconButton(
          onPressed: isBookmarked
              ? _viewModel.unbookmark //
              : _viewModel.bookmark,
          icon: Icon(icon),
        );
      },
    );
  }
}
