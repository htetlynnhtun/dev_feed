import 'package:dev_feed/feed/view/feed_item_view.dart';
import 'package:flutter/material.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: 20,
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
              child: const FeedItemView(),
            );
          },
        ),
      ),
    );
  }
}
