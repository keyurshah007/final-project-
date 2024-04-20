import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'candidates.dart';
import 'add_post.dart';

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
      backgroundColor: Colors.deepOrange[300],
        appBar: AppBar(
          backgroundColor: Colors.deepOrange[300],
          title: Text('Posts'),
          centerTitle: true, // Center the title and logo
          leading: Image.asset(
            'images/logo.png', // Replace 'assets/logo.png' with the path to your logo image
            width: 40, // Adjust the width of the logo as needed
          ),
        ),

      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4, // Adjust the elevation for shadow
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(posts[index].title),
              subtitle: Text(posts[index].content),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle adding a new post
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPostScreen(), // Create AddPostScreen
            ),
          ).then((_) {
            // Reload posts after adding a new post
            _loadPosts();
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
