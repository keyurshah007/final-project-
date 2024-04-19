import 'package:final_project/candidates.dart'; // Adjust the import path as needed

class Candidate {
  String name;
  String image;
  int age;
  String about;
  String job;
  List<Post> posts;

  // Updated constructor with default parameter values
  Candidate(
      this.name,
      this.image,
      this.age,
      this.about,
      this.job, {
        List<Post>? posts, // Nullable list of posts
      }) : posts = posts ?? []; // If posts is null, assign an empty list

}
