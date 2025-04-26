class UserModel {
  String firstName;
  String? userID;
  String lastName;
  String email;
  String about;
  String selectedGender;
  String? imagePath;
  List<String>? friends;
  List<String>? sendRequests;
  List<String>? receivedRequests;

  UserModel({
    required this.firstName,
    this.userID,
    this.friends,
    this.sendRequests,
    this.receivedRequests,
    required this.lastName,
    required this.email,
    required this.about,
    required this.selectedGender,
    this.imagePath,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName'] ?? '',
      userID: json['userId'] ?? '',
      lastName: json['lastName'] ?? '',
      friends: (json['friends'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      sendRequests: (json['sendRequests'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      receivedRequests: (json['receivedRequests'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      email: json['email'] ?? '',
      about: json['about'] ?? '',
      selectedGender: json['selectedGender'] ?? 'Male',
      imagePath: json['imagePath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'userId': userID,
      'lastName': lastName,
      'receivedRequests': receivedRequests,
      'sendRequests': sendRequests,
      'friends': friends,
      'email': email,
      'about': about,
      'selectedGender': selectedGender,
      'imagePath': imagePath,
    };
  }
}
