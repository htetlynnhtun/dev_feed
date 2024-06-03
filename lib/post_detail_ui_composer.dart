import 'package:dev_feed/post_detail/view/post_detail_page.dart';
import 'package:dev_feed/post_detail/viewmodel/post_detail_view_model.dart';

abstract class PostDetailUIComposer {
  static PostDetailPage detailPage(
    int postId,
    String postTitle,
  ) {
    return PostDetailPage(
      postId: postId,
      viewModelFactory: () {
        return PostDetailViewModel(
          postId: postId,
          postTitle: postTitle,
        );
      },
    );
  }
}
