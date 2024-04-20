import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateJobPage extends StatefulWidget {
  @override
  _CreateJobPageState createState() => _CreateJobPageState();
}

class _CreateJobPageState extends State<CreateJobPage> {
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange[300],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange[300],
        title: Text('Create Job'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Job Details',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _positionController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Position',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _companyController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Company',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _descriptionController,
              style: TextStyle(color: Colors.white),
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _saveJobDetails();
                },
                child: Text(
                  'Save',
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

  void _saveJobDetails() async {
    String position = _positionController.text;
    String company = _companyController.text;
    String description = _descriptionController.text;

    JobListing job = JobListing(
      position: position,
      company: company,
      description: description,
    );

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jobs = prefs.getStringList('jobs') ?? [];
    jobs.add(jsonEncode(job.toJson()));
    prefs.setStringList('jobs', jobs);

    Navigator.pop(context);
  }
}

class JobListing {
  final String position;
  final String company;
  final String description;

  JobListing({
    required this.position,
    required this.company,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'position': position,
      'company': company,
      'description': description,
    };
  }

  factory JobListing.fromJson(Map<String, dynamic> json) {
    return JobListing(
      position: json['position'],
      company: json['company'],
      description: json['description'],
    );
  }
}
