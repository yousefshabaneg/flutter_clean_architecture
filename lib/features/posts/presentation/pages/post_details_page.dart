import '../../domain/entities/post.dart';
import '../widgets/post_details_page/post_details_widget.dart';
import 'package:flutter/material.dart';

class PostDetailsPage extends StatelessWidget {
  final Post post;
  const PostDetailsPage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("Post Details"),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: PostDetailsWidget(post: post),
      ),
    );
  }
}
