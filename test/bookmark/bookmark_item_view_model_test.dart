import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bookmark_item_view_model_test.freezed.dart';

void main() {
  test('BookmarkItemVeiwModel has correct initial state of pending', () {
    final sut = BookmarkItemVeiwModel();

    expect(sut.value, const BookmarkItemViewState.pending());
  });
}

class BookmarkItemVeiwModel extends ValueNotifier<BookmarkItemViewState> {
  BookmarkItemVeiwModel() : super(const BookmarkItemViewState.pending());
}

@freezed
class BookmarkItemViewState with _$BookmarkItemViewState {
  const factory BookmarkItemViewState.pending() = Pending;
}
