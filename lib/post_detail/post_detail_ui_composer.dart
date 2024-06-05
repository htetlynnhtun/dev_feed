import 'package:dev_feed/async_image/model/image_data_loader.dart';
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
