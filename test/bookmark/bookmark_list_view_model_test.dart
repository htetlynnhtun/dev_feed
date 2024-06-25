import 'package:dev_feed/bookmark/cache/in_memory_bookmark_sotre.dart';
import 'package:dev_feed/bookmark/model/bookmark.dart';
import 'package:dev_feed/bookmark/viewmodel/bookmark_list_view_model.dart';

import '../helpers.dart';

void main() {
  final store = InMemoryBookmarkSotre();
  valueNotifierTest(
    'BookmarkListViewModel notifies [loaded] when loader emit new different bookmarks',
    arrange: () => BookmarkListViewModel(store.retrieveAll),
    act: (notifier) async {
      store.insert(Bookmark(id: '1', post: makePost(id: 1)));
      store.insert(Bookmark(id: '2', post: makePost(id: 2)));
      store.deleteById('2');
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
