import 'package:flutter/material.dart';

class FeedItemView extends StatelessWidget {
  const FeedItemView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 260,
            child: Image.network(
              'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'OS Fundamentals 101: Process and Syscalls',
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
                const Row(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          foregroundImage: NetworkImage(
                              'https://storage.googleapis.com/cms-storage-bucket/780e0e64d323aad2cdd5.png'),
                        ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Username'),
                            Text('May 31'),
                          ],
                        )
                      ],
                    ),
                    Spacer(),
                    Text('7 Likes'),
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
