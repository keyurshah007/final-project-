import 'package:flutter/material.dart';
import 'post.dart';
import 'candidates.dart';
import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}

class User {
  final String email;
  final String password;

  User({required this.email, required this.password});
}

List<User> users = [
  User(email: 'test@test.com', password: 'test'),
  User(email: 'keyur@gmail.com', password: 'abc'),
  User(email: 'aaa', password: 'aaa'),
];

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500), // Adjust the duration as needed
    );
    _slideAnimation = Tween<Offset>(begin: Offset(0.0, 1.5), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward(); // Start the animation when the screen is first displayed
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _login() {
    String enteredEmail = _emailController.text;
    String enteredPassword = _passwordController.text;

    bool isValidUser = users.any((user) =>
    user.email == enteredEmail && user.password == enteredPassword);

    if (isValidUser) {
      //Navigate to CandidateScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
      // _showSnackBar(context, 'successful login');
    } else {
      _showSnackBar(context, 'Invalid email or password');
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange[300],
      body: SingleChildScrollView(
        child: SlideTransition(
          position: _slideAnimation,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/logo.png',
                  width: 270,
                  height: 270,
                ),
                SizedBox(height: 32.0),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                  obscureText: true,
                ),
                SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 5,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.deepOrange[300],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
