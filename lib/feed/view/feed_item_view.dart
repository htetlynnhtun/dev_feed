import 'package:dev_feed/constants.dart';
import 'package:dev_feed/feed/viewmodel/post_view_model.dart';
import 'package:flutter/material.dart';

class FeedItemView extends StatelessWidget {
  final PostViewModel postViewModel;

  const FeedItemView({
    super.key,
    required this.postViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 200,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.network(
                postViewModel.coverImage ?? flutterImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  postViewModel.title,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Row(
                  children: [
                    Text(postViewModel.tags),
                    const Spacer(),
                    Text(postViewModel.readingTime),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.bookmark_border),
                      onPressed: () {},
                    ),
                  ],
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          foregroundImage: NetworkImage(postViewModel.userProfileImage),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(postViewModel.username),
                            Text(postViewModel.postedAt),
                          ],
                        )
                      ],
                    ),
                    const Spacer(),
                    Text(postViewModel.likeCountLabel),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
