import 'package:async_image/async_image.dart';

import 'package:dev_feed/post_detail/model/model.dart';
import 'package:dev_feed/post_detail/view/post_detail_page.dart';
import 'package:dev_feed/post_detail/viewmodel/post_detail_view_model.dart';

abstract class PostDetailUIComposer {
  static PostDetailPage detailPage(
    int postId,
    PostDetailsLoader postDetailsLoader,
    ImageDataLoader dataLoader,
  ) {
    return PostDetailPage(
      postId: postId,
      viewModelFactory: () {
        return PostDetailViewModel(
          postId: postId,
          postDetailsLoader: postDetailsLoader,
          imageDataLoader: dataLoader
        );
      },
    );
  }
}
