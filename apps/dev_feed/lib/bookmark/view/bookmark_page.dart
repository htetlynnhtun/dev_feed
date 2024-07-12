import 'package:flutter/material.dart';

import 'package:dev_feed/bookmark/model/bookmark_loader.dart';
import 'package:dev_feed/bookmark/viewmodel/bookmark_list_view_model.dart';
import 'package:dev_feed/posts_feed/model/post.dart';

class BookmarkPage extends StatefulWidget {
  final BookmarkListViewModel Function() viewModelFactory;
  final Widget Function(BuildContext context, List<Post> posts) postsListView;

  const BookmarkPage({
    super.key,
    required this.viewModelFactory,
    required this.postsListView,
  });

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  late final BookmarkListViewModel _viewModel;

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
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: _viewModel,
          builder: (context, state, child) {
            return switch (state) {
              Pending() => const Center(
                  child: CircularProgressIndicator(),
                ),
              Loaded(bookmarks: var bookmarks) => widget.postsListView(
                  context,
                  bookmarks.map((e) => e.post).toList(),
                ),
            };
          },
        ),
      ),
    );
  }
}

abstract class BookmarkPageComposer {
  static BookmarkPage compose({
    required BookmarkLoader  bookmarkLoader,
    required Widget Function(BuildContext, List<Post>) postListView,
  }) =>
      BookmarkPage(
        viewModelFactory: () => BookmarkListViewModel(bookmarkLoader),
        postsListView: postListView,
      );
}
