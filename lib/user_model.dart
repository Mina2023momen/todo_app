class UserModel {
  static const String collectionName="users";
  String id;
  String email;
  String phone;
  String username;
bool emailVerified;
  UserModel(
      {required this.id,
      required this.email,
      this.phone = "",
        this.emailVerified=false,
      required this.username});
  UserModel.fromJson(Map<String,dynamic>json):this(
    id: json['id'],
    phone: json['phone'],
    emailVerified: json['emailVerified'],
    username: json['username'],
    email: json['email'],

  );

  Map<String,dynamic>toJson(){
    return{
      "id": id,
      "phone": phone,
      "emailVerified": emailVerified,
      "username": username,
      "email": email,
    };
  }
}
