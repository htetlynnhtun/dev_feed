import 'package:flutter/material.dart';

import 'package:dev_feed/feed/view/feed_item_view.dart';
import 'package:dev_feed/feed/viewmodel/feed_view_model.dart';

class FeedPage extends StatefulWidget {
  final FeedViewModel Function() viewModelFactory;

  const FeedPage({
    super.key,
    required this.viewModelFactory,
  });

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  late final FeedViewModel viewModel;

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
                    return Padding(
                      padding: padding,
                      child: FeedItemView(post: posts[index]),
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
