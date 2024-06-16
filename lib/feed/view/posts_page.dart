import 'package:flutter/material.dart';

import 'package:dev_feed/feed/model/model.dart';
import 'package:dev_feed/feed/viewmodel/posts_view_model.dart';

class PostsPage extends StatefulWidget {
  final PostsViewModel Function() viewModelFactory;
  final Widget Function(BuildContext context, Post viewModel) postItemView;

  const PostsPage({
    super.key,
    required this.viewModelFactory,
    required this.postItemView,
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
              case Idle():
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
                    return Padding(
                      padding: padding,
                      child: widget.postItemView(context, posts[index]),
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

class DummyPostItem extends StatelessWidget {
  final String title;
  const DummyPostItem({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    print('===> DummyPostItem.build()');
    return Text(title);
  }
}
