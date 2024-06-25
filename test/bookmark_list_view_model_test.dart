import 'dart:async';

import 'package:dev_feed/bookmark/model/bookmark.dart';
import 'package:dev_feed/bookmark/viewmodel/bookmark_list_view_model.dart';

import 'helpers.dart';

void main() {
  final controller = StreamController<List<Bookmark>>();
  valueNotifierTest(
    'BookmarkListViewModel notifies [loaded] when loader emit new different bookmarks',
    arrange: () => BookmarkListViewModel(() => controller.stream),
    act: (notifier) {
      // added 1 bookmark
      controller.add([
        Bookmark(id: '1', post: makePost(id: 1)),
      ]);
      // added 2 bookmarks
      controller.add([
        Bookmark(id: '1', post: makePost(id: 1)),
        Bookmark(id: '2', post: makePost(id: 2)),
      ]);
      // remove last added bookmark
      controller.add([
        Bookmark(id: '1', post: makePost(id: 1)),
      ]);
    },
    expectedValues: [
      BookmarkListViewState.loaded([
        Bookmark(id: '1', post: makePost(id: 1)),
      ]),
      BookmarkListViewState.loaded([
        Bookmark(id: '1', post: makePost(id: 1)),
        Bookmark(id: '2', post: makePost(id: 2)),
      ]),
      BookmarkListViewState.loaded([
        Bookmark(id: '1', post: makePost(id: 1)),
      ]),
    ],
  );
}
