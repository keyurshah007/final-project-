import 'package:flutter/material.dart';
import 'candidate.dart';

class CandidateDetailsScreen extends StatefulWidget {
  final Candidate candidate;

  const CandidateDetailsScreen({required this.candidate});

  @override
  _CandidateDetailsScreenState createState() => _CandidateDetailsScreenState();
}

class _CandidateDetailsScreenState extends State<CandidateDetailsScreen> {
  bool isConnected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.candidate.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 150,
                backgroundImage: AssetImage(widget.candidate.image),
              ),
            ),
            SizedBox(height: 60),
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
            Spacer(), // Add Spacer to push the button to the bottom
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isConnected = !isConnected;
                  });
                },
                child: Text(isConnected ? 'Disconnect' : 'Connect'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

