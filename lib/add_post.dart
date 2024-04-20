import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPostScreen extends StatefulWidget {
  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange[300],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange[300],
        title: Text('Add Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Post Details',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _titleController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _contentController,
              style: TextStyle(color: Colors.white),
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Content',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _addPost();
                },
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addPost() async {
    // Retrieve post details from controllers
    String title = _titleController.text;
    String content = _contentController.text;

    // Perform action with post details, such as saving to database
    await _savePostToPreferences(title, content);

    // Navigate back to the previous screen
    Navigator.pop(context);
  }

  Future<void> _savePostToPreferences(String title, String content) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? connectedCandidates =
        prefs.getStringList('connected_candidates') ?? [];

    // Save the post details to shared preferences for each connected candidate
    for (var connectedCandidate in connectedCandidates) {
      List<String>? existingTitles =
          prefs.getStringList('$connectedCandidate\_posts') ?? [];
      List<String>? existingContents =
          prefs.getStringList('$connectedCandidate\_posts_content') ?? [];

      existingTitles.add(title);
      existingContents.add(content);

      prefs.setStringList('$connectedCandidate\_posts', existingTitles);
      prefs.setStringList('$connectedCandidate\_posts_content', existingContents);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}
