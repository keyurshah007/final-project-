// job_listings_page.dart
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'job_description.dart';
import 'add_job.dart';

class JobListingsPage extends StatefulWidget {
  @override
  _JobListingsPageState createState() => _JobListingsPageState();
}

class _JobListingsPageState extends State<JobListingsPage> {
  final List<JobListing> jobListings = [
    JobListing(
      position: 'Team Principal',
      company: 'Oracle Redbull Racing',
      image: 'images/rbr.jpg', // replace with your image path
      description: 'Looking for a fearless leader to navigate the chaotic world of Formula 1. Must be able to handle high-speed drama, pit stop politics, and the occasional crash landing. Previous experience driving at 200 mph not required, but definitely a plus!',
    ),
    JobListing(
      position: 'Second Driver',
      company: 'Mercedes AMG Petronas F1 Team',
      image: 'images/merc.jpg', // replace with your image path
      description: 'Are you a skilled driver with a need for speed? Join us as our Second Driver and experience the thrill of pushing the limits on the race track. Warning: may cause sudden bursts of adrenaline, championship celebrations, and excessive champagne showers.',
    ),
    JobListing(
      position: 'Chief Strategist',
      company: 'Scuderia Ferrari',
      image: 'images/ferrari.jpg', // replace with your image path
      description: 'Calling all masterminds! We need someone with a knack for strategy to help us outsmart the competition. Duties include devising cunning race plans, outmaneuvering rivals, and ensuring that our drivers have the best chance of reaching the podium. Must be comfortable with the occasional burst of Italian passion.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange[300],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange[300],
        title: Text('Job Listings'),
        centerTitle: true, // Center the title and logo
        leading: Image.asset(
          'images/logo.png', // Replace 'assets/logo.png' with the path to your logo image
          width: 40, // Adjust the width of the logo as needed
        ),
      ),
      body: ListView.builder(
        itemCount: jobListings.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // Navigate to job description page with page transition effect
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  duration: Duration(milliseconds: 500), // Adjust transition duration as needed
                  child: JobDescriptionPage(
                    jobListing: jobListings[index],
                  ),
                ),
              );
            },
            child: Hero(
              tag: 'jobCard${jobListings[index].position}',
              child: JobCard(
                jobListing: jobListings[index],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create job page with page transition effect
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              duration: Duration(milliseconds: 250), // Adjust transition duration as needed
              child: CreateJobPage(), // Define CreateJobPage
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class JobListing {
  final String position;
  final String company;
  final String image;
  final String description;
  bool applied;

  JobListing({required this.position, required this.company, required this.image, required this.description, this.applied = false});
}

class JobCard extends StatefulWidget {
  final JobListing jobListing;

  JobCard({required this.jobListing});

  @override
  _JobCardState createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
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
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0), // Increased padding for larger height
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.25, // 25% of the screen width
              height: 120,
              child: Image.asset(
                widget.jobListing.image,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0), // Adjusted padding for better alignment
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.jobListing.position,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 7),
                    Text(widget.jobListing.company),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
