// model for login and sign up
class UserModel {
  String? uid;

  UserModel({this.uid});
}

// model to access data from firestore
class UserData {
  String uid;
  String firstName;
  String lastName;
  String email;
  String profilePic;
  List crops;
  bool connected;

  UserData({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profilePic,
    required this.crops,
    required this.connected,
  });
}
