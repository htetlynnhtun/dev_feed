import 'package:dev_feed/async_image/model/image_data_loader.dart';
import 'package:dev_feed/async_image/viewmodel/async_image_view_model.dart';
import 'package:dev_feed/feed/model/model.dart';
import 'package:dev_feed/feed/view/posts_page.dart';
import 'package:dev_feed/feed/viewmodel/post_item_view_model.dart';
import 'package:dev_feed/feed/viewmodel/posts_view_model.dart';

abstract class FeedUIComposer {
  static PostsPage feedPage(
    PostLoader postLoader,
    ImageDataLoader dataLoader,
    void Function(int id) onFeedItemSelected,
  ) {
    return PostsPage(
      viewModelFactory: () {
        return PostsViewModel(
          loader: () async {
            final posts = await postLoader.load();
            return _adapt(posts, dataLoader);
          },
        );
      },
      onPostItemSelected: onFeedItemSelected,
    );
  }

  static List<PostItemViewModel> _adapt(
      List<Post> posts, ImageDataLoader dataLoader) {
    asyncImageViewModelFactory(url) => AsyncImageViewModel(
          imageURL: url,
          dataLoader: dataLoader,
        );
    return posts.map((post) {
      return PostItemViewModel(
        post: post,
        asyncImageViewModelFactory: asyncImageViewModelFactory,
      );
    }).toList();
  }
}
