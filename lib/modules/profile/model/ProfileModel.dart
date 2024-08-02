
class Profile {
 final int id;
 final  int userID;
 final String firstName;
 final String lastName;
 final String email;
 final String password;
 final String role;

  Profile({
    required  this.id,
    required this.userID,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.role,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] as int,
      userID: json['userID'] as int,
      firstName: json['first_name'] as String,
      lastName: json['last_name']as String,
      email: json['email'] as String,
      password: json['password']as String,
      role: json['role']as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userID': userID,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'role': role,
    };
  }
}