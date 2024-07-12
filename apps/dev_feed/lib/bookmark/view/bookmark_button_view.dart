import 'dart:async';

import 'package:dev_feed/bookmark/model/bookmark_creator.dart';
import 'package:dev_feed/bookmark/model/bookmark_deleter.dart';
import 'package:dev_feed/bookmark/model/bookmark_loader.dart';
import 'package:dev_feed/posts_feed/model/model.dart';
import 'package:flutter/material.dart';

class BookmarkButtonView extends StatefulWidget {
  final Post post;
  final BookmarkLoader bookmarkLoader;
  final BookmarkCreator bookmarkCreator;
  final BookmarkDeleter bookmarkDeleter;

  const BookmarkButtonView({
    super.key,
    required this.post,
    required this.bookmarkLoader,
    required this.bookmarkCreator,
    required this.bookmarkDeleter,
  });

  @override
  State<BookmarkButtonView> createState() => _BookmarkButtonViewState();
}

class _BookmarkButtonViewState extends State<BookmarkButtonView> {
  var isBookmarked = false;
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();

    _subscription = widget.bookmarkLoader().listen((bookmarks) {
      final isPostBookmarked =
          bookmarks.any((e) => e.post.id == widget.post.id);
      if (isBookmarked != isPostBookmarked) {
        setState(() {
          isBookmarked = isPostBookmarked;
        });
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void bookmark() {
    widget.bookmarkCreator.createWith(widget.post);
  }

  void unBookmark() {
    widget.bookmarkDeleter.deleteById(widget.post.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: isBookmarked
          ? unBookmark //
          : bookmark,
      icon: Icon(
        isBookmarked
            ? Icons.bookmark //
            : Icons.bookmark_outline,
      ),
    );
  }
}
