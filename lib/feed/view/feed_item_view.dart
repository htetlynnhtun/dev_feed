import 'package:dev_feed/constants.dart';
import 'package:dev_feed/feed/model/model.dart';
import 'package:flutter/material.dart';

class FeedItemView extends StatelessWidget {
  final Post post;

  const FeedItemView({
    super.key,
    required this.post,
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
                post.coverImage ?? flutterImage,
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
                  post.title,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Row(
                  children: [
                    const Text('#webdev #career #speaking'),
                    const Spacer(),
                    const Text('8 min read'),
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
                          foregroundImage: NetworkImage(post.user.profileImage),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(post.user.name),
                            const Text('May 31'),
                          ],
                        )
                      ],
                    ),
                    const Spacer(),
                    Text('${post.likeCount} Likes'),
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
