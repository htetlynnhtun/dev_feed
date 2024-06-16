import 'package:dev_feed/async_image/model/image_data_loader.dart';
import 'package:dev_feed/async_image/view/async_image_view.dart';
import 'package:dev_feed/async_image/viewmodel/async_image_view_model.dart';
import 'package:dev_feed/feed/model/model.dart';
import 'package:dev_feed/feed/view/post_item_view.dart';
import 'package:dev_feed/feed/view/posts_list_view.dart';
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
          loader: postLoader,
        );
      },
      loadedView: (context, posts) => PostsListView(
        posts: posts,
        itemView: (context, post) => PostItemView(
          postViewModel: PostItemViewModel(post),
          onTap: onFeedItemSelected,
          asyncImageView: (context, url) => AsyncImageView(
            imageUrl: url,
            viewModelFactory: (url) => AsyncImageViewModel(
              imageURL: url,
              dataLoader: dataLoader,
            ),
          ),
        ),
      ),
    );
  }
}
