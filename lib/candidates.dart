import 'package:flutter/material.dart';
import 'candidate.dart';
import 'candidate_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CandidateScreen(),
    );
  }
}

class CandidateScreen extends StatelessWidget {
  final List<Candidate> candidates = [
    Candidate(
      name: 'Lewis Hamilton',
      image: 'assets/lewis_hamilton.jpg',
      age: 37,
      about: 'Seven-time Formula One World Champion',
      job: 'F1 Driver',
    ),
    Candidate(
      name: 'Max Verstappen',
      image: 'assets/max_verstappen.jpg',
      age: 24,
      about: 'Formula One driver currently competing for Red Bull Racing',
      job: 'F1 Driver',
    ),
    Candidate(
      name: 'Valtteri Bottas',
      image: 'assets/valtteri_bottas.jpg',
      age: 32,
      about: 'Finnish racing driver currently competing for Mercedes',
      job: 'F1 Driver',
    ),
    Candidate(
      name: 'Sergio Perez',
      image: 'assets/sergio_perez.jpg',
      age: 31,
      about: 'Mexican racing driver currently competing for Red Bull Racing',
      job: 'F1 Driver',
    ),
    Candidate(
      name: 'Charles Leclerc',
      image: 'assets/charles_leclerc.jpg',
      age: 24,
      about: 'Monegasque racing driver currently driving for Ferrari',
      job: 'F1 Driver',
    ),
    Candidate(
      name: 'Daniel Ricciardo',
      image: 'assets/daniel_ricciardo.jpg',
      age: 32,
      about: 'Australian racing driver currently competing for McLaren',
      job: 'F1 Driver',
    ),
    Candidate(
      name: 'Lando Norris',
      image: 'assets/lando_norris.jpg',
      age: 22,
      about: 'British racing driver currently competing for McLaren',
      job: 'F1 Driver',
    ),
    Candidate(
      name: 'Carlos Sainz',
      image: 'assets/carlos_sainz.jpg',
      age: 27,
      about: 'Spanish racing driver currently competing for Ferrari',
      job: 'F1 Driver',
    ),
    Candidate(
      name: 'Fernando Alonso',
      image: 'assets/fernando_alonso.jpg',
      age: 40,
      about: 'Spanish racing driver currently competing for Alpine',
      job: 'F1 Driver',
    ),
    Candidate(
      name: 'Sebastian Vettel',
      image: 'assets/sebastian_vettel.jpg',
      age: 34,
      about: 'German racing driver currently competing for Aston Martin',
      job: 'F1 Driver',
    ),
    // Add more candidates as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange[300],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange[300],

        title: Text('Candidates'),

        leading: Image.asset(
          'images/logo.png', // Replace 'assets/logo.png' with the path to your logo image
          width: 40, // Adjust the width of the logo as needed
        ),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 0.5, // Spacing between columns
          mainAxisSpacing: 0.5, // Spacing between rows
          childAspectRatio: 1.0, // Aspect ratio of each grid item
        ),
        itemCount: candidates.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigate to candidate details screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CandidateDetailsScreen(candidate: candidates[index])),
              );
            },
            child: Card(
            color: Colors.teal[100],
            elevation: 3,
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
           ),

            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: AssetImage(candidates[index].image),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    candidates[index].name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ));
        },
      ),
    );
  }
}
