import '../../../domain/entities/post.dart';
import '../../pages/post_details_page.dart';
import 'package:flutter/material.dart';

class PostListWidget extends StatelessWidget {
  final List<Post> posts;
  const PostListWidget({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => PostWidget(post: posts[index]),
      separatorBuilder: (_, __) => const Divider(thickness: 1),
      itemCount: posts.length,
    );
  }
}

class PostWidget extends StatelessWidget {
  final Post post;
  const PostWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(post.id.toString()),
      title: Text(
        post.title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(post.body, style: const TextStyle(fontSize: 16)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => PostDetailsPage(post: post)));
      },
    );
  }
}
