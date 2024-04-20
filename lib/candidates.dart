import 'package:flutter/material.dart';
import 'candidate.dart';
import 'candidate_detail.dart';

class Post {
  final String title;
  final String content;

  Post({required this.title, required this.content});
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
    };
  }
}

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
      'Lewis Hamilton',
      'images/max.jpeg',
      37,
      'Seven-time Formula One World Champion',
      'F1 Driver',
      posts: [
        Post(
          title: 'My First Post',
          content: 'This is the content of my first post.',
        ),
        Post(
          title: 'Another Post',
          content: 'This is another post.',
        ),
      ],
    ),
    Candidate(
      'Max Verstappen',
      'images/perez.jpeg',
      24,
       'Formula One driver currently competing for Red Bull Racing',
       'F1 Driver',
      posts: [
        Post(
          title: 'Verstappen\'s Victory',
          content: 'Recap of Verstappen\'s latest race victory.',
        ),
      ],
    ),
    Candidate(
       'Valtteri Bottas',
       'images/hamilton.jpeg',
      32,
       'Finnish racing driver currently competing for Mercedes',
       'F1 Driver',
      posts: [
        Post(
          title: 'Bottas\'s Update',
          content: 'Updates from Valtteri Bottas on his upcoming race.',
        ),
      ],
    ),
    Candidate(
       'Sergio Perez',
       'images/russel.jpeg',
       31,
       'Mexican racing driver currently competing for Red Bull Racing',
       'F1 Driver',
      posts: [
        Post(
          title: 'Perez\'s Progress',
          content: 'Trackside insights from Sergio Perez.',
        ),
      ],
    ),
    // Candidate(
    //   name: 'Charles Leclerc',
    //   image: 'images/cahrles.jpeg',
    //   age: 24,
    //   about: 'Monegasque racing driver currently driving for Ferrari',
    //   job: 'F1 Driver',
    //   posts: [
    //     Post(
    //       title: 'Leclerc\'s Thoughts',
    //       content: 'Thoughts from Charles Leclerc on his performance.',
    //     ),
    //   ],
    // ),
    // Candidate(
    //   name: 'Daniel Ricciardo',
    //   image: 'images/carlos.jpeg',
    //   age: 32,
    //   about: 'Australian racing driver currently competing for McLaren',
    //   job: 'F1 Driver',
    //   posts: [
    //     Post(
    //       title: 'Ricciardo\'s Racing Tips',
    //       content: 'Tips and tricks from Daniel Ricciardo for aspiring drivers.',
    //     ),
    //   ],
    // ),
    // Candidate(
    //   name: 'Lando Norris',
    //   image: 'images/lando.jpeg',
    //   age: 22,
    //   about: 'British racing driver currently competing for McLaren',
    //   job: 'F1 Driver',
    //   posts: [
    //     Post(
    //       title: 'Norris\'s News',
    //       content: 'Latest updates from Lando Norris.',
    //     ),
    //   ],
    // ),
    // Candidate(
    //   name: 'Carlos Sainz',
    //   image: 'images/piastri.jpeg',
    //   age: 27,
    //   about: 'Spanish racing driver currently competing for Ferrari',
    //   job: 'F1 Driver',
    //   posts: [
    //     Post(
    //       title: 'Sainz\'s Strategy',
    //       content: 'Insights into Carlos Sainz\'s racing strategy.',
    //     ),
    //   ],
    // ),
    // Candidate(
    //   name: 'Fernando Alonso',
    //   image: 'images/alonso.jpeg',
    //   age: 40,
    //   about: 'Spanish racing driver currently competing for Alpine',
    //   job: 'F1 Driver',
    //   posts: [
    //     Post(
    //       title: 'Alonso\'s Analysis',
    //       content: 'Analyzing Fernando Alonso\'s recent performances.',
    //     ),
    //   ],
    // ),
    // Candidate(
    //   name: 'Sebastian Vettel',
    //   image: 'images/ricardo.jpeg',
    //   age: 34,
    //   about: 'German racing driver currently competing for Aston Martin',
    //   job: 'F1 Driver',
    //   posts: [
    //     Post(
    //       title: 'Vettel\'s View',
    //       content: 'Sebastian Vettel shares his views on the upcoming race.',
    //     ),
    //   ],
    // ),
    // Add more candidates as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange[300],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange[300],
        title: Text('Candidates'),
        centerTitle: true, // Center the title and logo
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
