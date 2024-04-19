import 'package:flutter/material.dart';
import 'post.dart';
import 'job_listings.dart';
import 'candidates.dart';
import 'candidate.dart';
import 'candidate_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Navigation Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      PostScreen(),
      JobListingsPage(),
      CandidateScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Job Listings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Candidates',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
