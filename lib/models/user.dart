class User {
    int userId;
    String username;
    String profilePictureUrl;
    int? roleId;

    User({required this.userId,required this.username, required this.profilePictureUrl , required this.roleId});

    factory User.fromJson(Map<String,dynamic> json){
      return User(
        userId: json['id'] as int, 
        username: json['username'] as String, 
        profilePictureUrl: json['profilePictureUrl'] ?? "",
        roleId: json['roleId']
      );
    }


}