import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'job_listings.dart';

class JobDescriptionPage extends StatefulWidget {
  final JobListing jobListing;

  JobDescriptionPage({required this.jobListing});

  @override
  _JobDescriptionPageState createState() => _JobDescriptionPageState();
}

class _JobDescriptionPageState extends State<JobDescriptionPage> {
  late bool _applied;

  @override
  void initState() {
    super.initState();
    _getAppliedStatus();
  }

  Future<void> _getAppliedStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _applied = prefs.getBool(widget.jobListing.position) ?? false;
    });
  }

  void _applyForJob() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(widget.jobListing.position, true);
    setState(() {
      _applied = true;
    });
    // You can add additional logic here, such as sending application details to a server
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.jobListing.position),
        backgroundColor: Colors.deepOrange[300], // Set app bar background color
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.jobListing.company,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                widget.jobListing.image,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: 200, // Set image height
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Description:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(widget.jobListing.description),
            SizedBox(height: 20),
            _applied
                ? Text(
              'Applied',
              style: TextStyle(color: Colors.green, fontSize: 18),
            )
                : ElevatedButton(
              onPressed: () {
                _applyForJob();
              },
              child: Text(
                'Apply',
                style: TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                // Set button background color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
