import 'package:dev_feed/post_detail/viewmodel/post_detail_view_model.dart';
import 'package:flutter/material.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(viewModel.postTitle),
      ),
    );
  }
}
