class User {
  final String uid;
  final String email;
  final String name;
  final String phoneNumber;
  final String? imageUrl = "";

  User(
      {required this.uid,
      required this.email,
      required this.name,
      required this.phoneNumber,
      imageUrl = ""});
}
