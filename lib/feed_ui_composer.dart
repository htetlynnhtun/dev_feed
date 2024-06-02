

import 'package:dev_feed/feed/model/model.dart';
import 'package:dev_feed/feed/view/feed_page.dart';
import 'package:dev_feed/feed/viewmodel/feed_view_model.dart';
import 'package:dev_feed/feed/viewmodel/post_view_model.dart';

abstract class FeedUIComposer {
  static FeedPage feedPage(PostLoader postLoader) {
    return FeedPage(viewModelFactory: () {
      return FeedViewModel(
        loader: postLoader,
        postViewModelFactory: PostViewModel.new,
      );
    });
  }
}
