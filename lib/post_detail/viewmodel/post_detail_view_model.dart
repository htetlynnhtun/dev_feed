typedef PostDetailViewModelFactory = PostDetailViewModel Function();

class PostDetailViewModel {
  final int postId;
  final String postTitle;

  PostDetailViewModel({
    required this.postId,
    required this.postTitle,
  });
}
