import 'package:flutter/material.dart';

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
    void Function(int id) onPostItemSelected,
  ) {
    return PostsPage(
      viewModelFactory: () {
        return PostsViewModel(
          loader: postLoader,
        );
      },
      loadedView: (context, posts) => PostsListView(
        key: const ValueKey('post-loaded-view'),
        posts: posts,
        itemView: (context, post) => PostItemView(
          key: ValueKey(post.id),
          postViewModel: PostItemViewModel(post),
          onTap: onPostItemSelected,
          asyncImageView: (context, url) => AsyncImageView(
            key: ValueKey(url),
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
