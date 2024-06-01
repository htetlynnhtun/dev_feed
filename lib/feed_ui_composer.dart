import 'package:dev_feed/feed/api/remote_post_loader.dart';
import 'package:dev_feed/feed/view/feed_page.dart';
import 'package:dev_feed/feed/viewmodel/feed_view_model.dart';
import 'package:dev_feed/feed/viewmodel/post_view_model.dart';
import 'package:http/http.dart' as http;

abstract class FeedUIComposer {
  static FeedPage feedPage() {
    return FeedPage(viewModelFactory: () {
      return FeedViewModel(
        loader: RemotePostLoader(
          client: http.Client(),
        ),
        postViewModelFactory: PostViewModel.new,
      );
    });
  }
}
