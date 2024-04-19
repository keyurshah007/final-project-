import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'candidate.dart';
import 'post.dart';
import 'candidates.dart';

class CandidateDetailsScreen extends StatefulWidget {
  final Candidate candidate;

  const CandidateDetailsScreen({required this.candidate});

  @override
  _CandidateDetailsScreenState createState() => _CandidateDetailsScreenState();
}

class _CandidateDetailsScreenState extends State<CandidateDetailsScreen> {
  bool isConnected = false;
  List<Post> connectedPosts = [];

  @override
  void initState() {
    super.initState();
    _loadConnectionStatus();
    _loadConnectedPosts();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadConnectionStatus();
    _loadConnectedPosts();
  }

  Future<void> _loadConnectionStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool connected =
        prefs.getBool(widget.candidate.name + "_connected") ?? false;
    setState(() {
      isConnected = connected;
    });
  }

  Future<void> _loadConnectedPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (isConnected) {
      List<String>? postTitles =
      prefs.getStringList('${widget.candidate.name}_posts');
      List<String>? postContents = prefs.getStringList(
          '${widget.candidate.name}_posts_content');
      if (postTitles != null && postContents != null) {
        List<Post> posts = [];
        for (int i = 0; i < postTitles.length; i++) {
          posts.add(Post(title: postTitles[i], content: postContents[i]));
        }
        setState(() {
          connectedPosts = posts;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.candidate.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 150,
                      backgroundImage: AssetImage(widget.candidate.image),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _connectWithCandidate(widget.candidate);
                      },
                      child: Text(isConnected ? 'Disconnect' : 'Connect'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          isConnected ? Colors.red : Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Name: ${widget.candidate.name}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Age: ${widget.candidate.age}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Job: ${widget.candidate.job}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'About: ${widget.candidate.about}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Posts:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: connectedPosts.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            connectedPosts[index].title,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            connectedPosts[index].content,
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _connectWithCandidate(Candidate candidate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? connectedCandidates =
        prefs.getStringList('connected_candidates') ?? [];

    if (!connectedCandidates.contains(candidate.name)) {
      connectedCandidates.add(candidate.name);
      await prefs.setStringList('connected_candidates', connectedCandidates);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Connected with ${candidate.name}')),
      );
      List<String> postTitles = [];
      List<String> postContents = [];
      for (var post in candidate.posts) {
        postTitles.add(post.title);
        postContents.add(post.content);
      }
      await prefs.setStringList('${candidate.name}_posts', postTitles);
      await prefs.setStringList(
          '${candidate.name}_posts_content', postContents);
      setState(() {
        isConnected = true;
        connectedPosts = candidate.posts;
        _saveConnectionStatus();
      });
    } else {
      connectedCandidates.remove(candidate.name);
      await prefs.setStringList('connected_candidates', connectedCandidates);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Disconnected from ${candidate.name}')),
      );
      await prefs.remove('${candidate.name}_posts');
      await prefs.remove('${candidate.name}_posts_content');
      setState(() {
        isConnected = false;
        connectedPosts = [];
        _saveConnectionStatus();
      });
    }
  }

  void _saveConnectionStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(widget.candidate.name + "_connected", isConnected);
  }
}
