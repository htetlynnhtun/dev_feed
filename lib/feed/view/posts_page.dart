import 'package:flutter/material.dart';

import 'package:dev_feed/feed/view/post_item_view.dart';
import 'package:dev_feed/feed/viewmodel/posts_view_model.dart';

class PostsPage extends StatefulWidget {
  final PostsViewModel Function() viewModelFactory;
  final void Function(int) onPostItemSelected;

  const PostsPage({
    super.key,
    required this.viewModelFactory,
    required this.onPostItemSelected,
  });

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  late final PostsViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModelFactory();
    viewModel.load();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: viewModel,
          builder: (context, value, child) {
            switch (value) {
              case Loading():
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case Loaded(posts: var posts):
                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final isFirstItem = index == 0;
                    var padding = const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 16,
                    );
                    if (isFirstItem) {
                      padding += const EdgeInsets.only(top: 16.0);
                    }
                    return GestureDetector(
                      onTap: () => widget.onPostItemSelected(posts[index].id),
                      child: Padding(
                        padding: padding,
                        child: PostItemView(postViewModel: posts[index]),
                      ),
                    );
                  },
                );

              case failure(message: var message):
                return Center(child: Text(message));
            }
          },
        ),
      ),
    );
  }
}
