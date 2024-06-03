import "package:dev_feed/feed/viewmodel/async_image_view_model.dart";
import 'package:dev_feed/constants.dart';
import 'package:dev_feed/feed/model/model.dart';
import 'package:dev_feed/feed/view/feed_page.dart';
import 'package:dev_feed/feed/viewmodel/feed_view_model.dart';
import 'package:dev_feed/feed/viewmodel/post_view_model.dart';

abstract class FeedUIComposer {
  static FeedPage feedPage(
    PostLoader postLoader,
    ImageDataLoader dataLoader,
  ) {
    return FeedPage(viewModelFactory: () {
      return FeedViewModel(
        loader: postLoader,
        postViewModelFactory: (post) => PostViewModel(
          post: post,
          coverImageViewModelFactory: () => AsyncImageViewModel(
            imageURL: post.coverImage ?? flutterImage,
            dataLoader: dataLoader,
          ),
        ),
      );
    });
  }
}
