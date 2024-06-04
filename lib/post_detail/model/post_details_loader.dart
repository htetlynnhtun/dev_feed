import 'package:async/async.dart';
import 'package:dev_feed/post_detail/model/post_details.dart';

abstract class PostDetailsLoader {
  CancelableOperation<PostDetails> load(int postId);
}
