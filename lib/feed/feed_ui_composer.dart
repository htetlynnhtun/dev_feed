import 'package:dev_feed/feed/model/model.dart';
import 'package:dev_feed/feed/view/posts_page.dart';
import 'package:dev_feed/feed/viewmodel/posts_view_model.dart';
import 'package:dev_feed/feed/viewmodel/post_item_view_model.dart';
import 'package:dev_feed/shared/viewmodel/view_model.dart';

abstract class FeedUIComposer {
  static PostsPage feedPage(
    PostLoader postLoader,
    ImageDataLoader dataLoader,
    void Function(int id) onFeedItemSelected,
  ) {
    return PostsPage(
      viewModelFactory: () {
        return PostsViewModel(
          loader: postLoader,
          postViewModelFactory: (post) => PostItemViewModel(
            post: post,
            asyncImageViewModelFactory: (url) => AsyncImageViewModel(
              imageURL: url,
              dataLoader: dataLoader,
            ),
          ),
        );
      },
      onPostItemSelected: onFeedItemSelected,
    );
  }
}
