import 'package:flutter/material.dart';

class JobListingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Listings Page'),
      ),
      body: Center(
        child: Text(
          'This is the Job Listings Page',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
