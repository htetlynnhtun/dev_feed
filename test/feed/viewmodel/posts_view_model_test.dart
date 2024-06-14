import 'package:mockito/annotations.dart';
import 'package:test/test.dart';

import 'package:dev_feed/feed/viewmodel/post_item_view_model.dart';
import 'package:dev_feed/feed/viewmodel/posts_view_model.dart';

import 'posts_view_model_test.mocks.dart';

abstract class ItemsLoader {
  Future<List<PostItemViewModel>> load();
}

@GenerateNiceMocks([MockSpec<ItemsLoader>()])
void main() {
  group('PostsViewModel', () {
    test('has correct initial state', () {
      final mockedItemsLoader = MockItemsLoader();
      final sut = PostsViewModel(loader: mockedItemsLoader.load);

      expect(sut.value, const PostsViewState.loading());
    });
  });
}
