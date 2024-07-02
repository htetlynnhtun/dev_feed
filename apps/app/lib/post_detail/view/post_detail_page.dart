import 'package:flutter/material.dart';

import 'package:dev_feed/post_detail/view/post_details_view.dart';
import 'package:dev_feed/post_detail/viewmodel/post_detail_view_model.dart';

class PostDetailPage extends StatefulWidget {
  final int postId;
  final PostDetailViewModelFactory viewModelFactory;

  const PostDetailPage({
    super.key,
    required this.postId,
    required this.viewModelFactory,
  });

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  late final PostDetailViewModel viewModel;

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
      appBar: AppBar(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: viewModel,
          builder: (context, value, child) {
            switch (value) {
              case Loading():
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case Loaded(viewData: final viewData):
                return PostDetailsView(viewData: viewData);

              case Failure(message: var message):
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: viewModel.load,
                      icon: const Icon(Icons.refresh),
                    ),
                    Text(message),
                  ],
                );
            }
          },
        ),
      ),
    );
  }
}
