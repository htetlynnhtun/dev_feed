import 'dart:async';

import 'package:dev_feed/bookmark/model/bookmark.dart';
import 'package:dev_feed/bookmark/model/bookmark_creator.dart';
import 'package:dev_feed/posts_feed/model/post.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart/subjects.dart';

import '../helpers.dart';

part 'bookmark_item_view_model_test.freezed.dart';

void main() {
  (BookmarkItemVeiwModel, BookmarkSpy, Post) makeSUT() {
    final bookmarkStream = BehaviorSubject<List<Bookmark>>();
    final post = makePost(id: 7);
    final bookmarkSpy = BookmarkSpy();
    final sut = BookmarkItemVeiwModel(
      post: post,
      bookmarkCreator: bookmarkSpy,
      bookmarkDeleter: bookmarkSpy,
      bookmarkStream: bookmarkStream,
    );
    return (sut, bookmarkSpy, post);
  }

  test('BookmarkItemVeiwModel has correct initial state of pending', () {
    final (sut, _, _) = makeSUT();

    expect(sut.value, const BookmarkItemViewState.pending());
  });

  test(
    'BookmarkItemViewModel .bookmark() requests '
    'creation of a bookmark for the post',
    () {
      final (sut, bookmarkSpy, post) = makeSUT();

      sut.bookmark();

      expect(bookmarkSpy.messages, [
        _ReceivedMessages.createWith(post),
      ]);
    },
  );

  test(
    'BookmarkItemViewModel .unbookmark() requests '
    'deletion of a bookmark for the post',
    () {
      final (sut, bookmarkSpy, post) = makeSUT();

      sut.unbookmark();

      expect(bookmarkSpy.messages, [
        _ReceivedMessages.deleteFor(post),
      ]);
    },
  );

  valueNotifierTest(
    'BookmarkItemViewModel notifies [bookmarked] when '
    'the post is bookmarked',
    arrange: () => makeSUT().$1,
    act: (sut) => sut.bookmark(),
    expectedValues: [const BookmarkItemViewState.bookmarked()],
    skip: 'TODO: implement BookmarkStore first'
  );
}

@freezed
class _ReceivedMessages with _$ReceivedMessages {
  const factory _ReceivedMessages.createWith(Post post) = CreateWith;
  const factory _ReceivedMessages.deleteFor(Post post) = DeleteFor;
}

class BookmarkSpy implements BookmarkCreator, BookmarkDeleter {
  final messages = <_ReceivedMessages>[];

  @override
  Future<void> createWith(Post post) async {
    messages.add(_ReceivedMessages.createWith(post));
  }

  @override
  Future<void> deleteFor(Post post) async {
    messages.add(_ReceivedMessages.deleteFor(post));
  }
}

class BookmarkItemVeiwModel extends ValueNotifier<BookmarkItemViewState> {
  final BookmarkCreator bookmarkCreator;
  final BookmarkDeleter bookmarkDeleter;
  final Post post;
  late final StreamSubscription _subscription;

  BookmarkItemVeiwModel({
    required this.post,
    required this.bookmarkCreator,
    required this.bookmarkDeleter,
    required Stream<List<Bookmark>> bookmarkStream,
  }) : super(const BookmarkItemViewState.pending()) {
    _subscription = bookmarkStream.listen((bookmarks) {
      final isBookmarked =
          bookmarks.any((bookmark) => bookmark.post.id == post.id);
      if (isBookmarked) {
        value = const BookmarkItemViewState.bookmarked();
      }
    });
  }

  void bookmark() {
    bookmarkCreator.createWith(post);
  }

  void unbookmark() {
    bookmarkDeleter.deleteFor(post);
  }
}

abstract class BookmarkDeleter {
  Future<void> deleteFor(Post post);
}

@freezed
class BookmarkItemViewState with _$BookmarkItemViewState {
  const factory BookmarkItemViewState.pending() = Pending;
  const factory BookmarkItemViewState.bookmarked() = Bookmarked;
}
