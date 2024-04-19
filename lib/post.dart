import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'candidates.dart';
class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? connectedCandidates =
        prefs.getStringList('connected_candidates') ?? [];

    List<Post> allPosts = [];
    for (var connectedCandidate in connectedCandidates) {
      List<String>? postTitles =
      prefs.getStringList('$connectedCandidate\_posts');
      List<String>? postContents = prefs.getStringList(
          '$connectedCandidate\_posts_content');
      if (postTitles != null && postContents != null) {
        for (int i = 0; i < postTitles.length; i++) {
          allPosts.add(Post(
            title: postTitles[i],
            content: postContents[i],
          ));
        }
      }
    }

    setState(() {
      posts = allPosts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connected Posts'),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(posts[index].title),
            subtitle: Text(posts[index].content),
          );
        },
      ),
    );
  }
}

