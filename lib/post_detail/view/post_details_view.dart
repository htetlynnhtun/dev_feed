import 'package:flutter/material.dart';

import 'package:dev_feed/async_image/view/async_image_view.dart';
import 'package:dev_feed/post_detail/viewmodel/post_detail_view_model.dart';

class PostDetailsView extends StatelessWidget {
  final PostDetailViewData viewData;

  const PostDetailsView({
    super.key,
    required this.viewData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 200,
          child: AsyncImageView(
            imageUrl: viewData.coverImage,
            viewModelFactory: viewData.asyncImageViewModelFactory,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 50,
                    child: ClipOval(
                      child: AsyncImageView(
                        imageUrl: viewData.userProfileImage,
                        viewModelFactory: viewData.asyncImageViewModelFactory,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(viewData.username),
                      Text(viewData.publishAt),
                    ],
                  )
                ],
              ),
              Text(
                viewData.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(viewData.tags),
            ],
          ),
        ),
      ],
    );
  }
}
