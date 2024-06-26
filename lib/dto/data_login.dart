class DataLogin {
  final String message;
  final String roles;
  final int userLogged;

  DataLogin({
    required this.message,
    required this.roles,
    required this.userLogged,
  });

  // From JSON
  factory DataLogin.fromJson(Map<String, dynamic> json) {
    return DataLogin(
      message: json['message'],
      roles: json['roles'],
      userLogged: json['user_logged'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'roles': roles,
      'user_logged': userLogged,
    };
  }
}
