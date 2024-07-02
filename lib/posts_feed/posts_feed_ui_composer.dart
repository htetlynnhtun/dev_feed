import 'package:flutter/material.dart';

import 'package:dev_feed/posts_feed/model/model.dart';
import 'package:dev_feed/posts_feed/view/posts_page.dart';
import 'package:dev_feed/posts_feed/viewmodel/posts_view_model.dart';

abstract class FeedUIComposer {
  static PostsPage feedPage(
    PostLoader postLoader,
    Widget Function(BuildContext, List<Post>) postsListView,
  ) {
    return PostsPage(
      viewModelFactory: () {
        return PostsViewModel(
          loader: postLoader,
        );
      },
      loadedView: postsListView,
    );
  }
}
