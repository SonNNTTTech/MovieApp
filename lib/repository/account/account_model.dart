class UserResponse {
  int? id;
  String? username;

  UserResponse({this.id, this.username});

  UserResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
  }
}
