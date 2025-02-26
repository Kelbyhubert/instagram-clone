class User {
    int userId;
    String username;
    String profilePictureUrl;

    User({required this.userId,required this.username, required this.profilePictureUrl});

    factory User.fromJson(Map<String,dynamic> json){
      return User(
        userId: json['id'] as int, 
        username: json['username'] as String, 
        profilePictureUrl: json['profilePictureUrl'] ?? ""
      );
    }


}