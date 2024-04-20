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
      'Max Verstappen',
      'images/max.jpeg',
      26,
      'Max Verstappen is a professional driver who believes speed is his middle name. He once raced a cheetah... and won.',
      'F1 Driver',
      posts: [
        Post(
          title: 'Max Verstappen',
          content: 'Just finished an intense training session. Ready to hit the track and chase victory! #SimplyLovely',
        ),
        Post(
          title: 'Max Verstappen',
          content: 'Another day, another Win 🏆 Thanks to my amazing team and fans for the support.',
        ),
      ],
    ),
    Candidate(
      'Sergio Perez',
      'images/perez.jpeg',
      29,
      'Sergio Perez, also known as "Mexican Minister of Defence," once outpaced a tornado on the track. He claims it was just another day at the office.',
      'F1 Driver',
      posts: [
        Post(
          title: 'Sergio Perez',
          content: 'Not Sure will I have a Seat for 2025, but still Red Bull Racing on TOP! 🏆🇲🇽 #Checo',
        ),
      ],
    ),
    Candidate(
      'Lewis Hamilton',
      'images/hamilton.jpeg',
      38,
      'Lewis Hamilton, also known as "OLD DOG," 7 Time word drivers champion',
      'F1 Driver',
      posts: [
        Post(
          title: 'Lewis Hamilton',
          content: 'Life is all about pushing the boundaries and chasing dreams. #TeamLH #StillWeRise',
        ),
      ],
    ),
    Candidate(
      'George Russel',
      'images/russel.jpeg',
      27,
      'George Russel, also known as "The Silent Speedster," once won a race without saying a word. Legend has it, his car just knew where to go.',
      'F1 Driver',
      posts: [
        Post(
          title: 'George Russel',
          content: 'RED FLAG!! RED FLAG!! RED FLAG!! RED FLAG!! RED FLAG!! RED FLAG!! RED FLAG!!',
        ),
      ],
    ),
    Candidate(
      'Charles Leclerc',
      'images/cahrles.jpeg',
      26,
      'Charles Leclerc, also known as "The Monaco Marvel," once drove his car backward just to see if anyone would notice. Spoiler alert: They didn\'t.',
      'F1 Driver',
      posts: [
        Post(
          title: 'Charles Leclerc',
          content: 'I am Stupid, I am stupid, Nooooooooo!!!!!!!',
        ),
      ],
    ),
    Candidate(
      'Carlos Sainz',
      'images/carlos.jpeg',
      26,
      'Carlos Sainz, also known as "The Spanish Sensation," once made his pit crew do the Macarena during a tire change. They still don\'t know why.',
      'F1 Driver',
      posts: [
        Post(
          title: 'Carlos Sainz',
          content: 'Smooth Operatooooorrrrrr',
        ),
      ],
    ),
    Candidate(
      'Lando Norris',
      'images/lando.jpeg',
      23,
      'Lando Norris, also known as "The British Bullet," once won a race blindfolded... just for fun. His excuse? He wanted to test his luck.',
      'F1 Driver',
      posts: [
        Post(
          title: 'Lando Norris',
          content: "Dont know when I'll win a race, but mommy i did a thing #LN4",
        ),
      ],
    ),
    Candidate(
      'Oscar Piastri',
      'images/piastri.jpeg',
      22,
      'Oscar Piastri, also known as "The Aussie Ace," once took a detour through the outback during a race. He claimed he was just saying hello to the kangaroos.',
      'F1 Driver',
      posts: [
        Post(
          title: 'Oscar Piastri',
          content: 'Embracing the journey and striving for greatness. Keep believing, keep pushing! 🇦🇺 #OP31',
        ),
      ],
    ),
    Candidate(
      'Fernando Alonso',
      'images/alonso.jpeg',
      40,
      'Fernando Alonso, also known as "The Spanish Samurai," once won a race while juggling oranges... because why not?',
      'F1 Driver',
      posts: [
        Post(
          title: 'Fernando Alonso',
          content: 'Experience is the key to success. Learning from every lap and every race. #FA14',
        ),
      ],
    ),
    Candidate(
      'Daniel Ricciardo',
      'images/ricardo.jpeg',
      34,
      'Daniel Ricciardo, also known as "Honey Badger," once convinced his car to do a backflip... just to impress his fans.',
      'F1 Driver',
      posts: [
        Post(
          title: 'Daniel Ricciardo',
          content: 'Daniel Ricciardo shares his views on the upcoming race. #DR3',
        ),
      ],
    ),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange[300],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange[300],
        title: Text('Candidates'),
        centerTitle: true,
        leading: Image.asset(
          'images/logo.png',
          width: 40,
        ),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0.5,
          mainAxisSpacing: 0.5,
          childAspectRatio: 1.0,
        ),
        itemCount: candidates.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {

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
