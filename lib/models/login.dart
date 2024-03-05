class UserLogin {
  final String email;
  final String password;

  UserLogin({
    required this.email,
    required this.password,
  });

  factory UserLogin.fromJson(Map<String, dynamic> json) {
    return UserLogin(
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

// class LoginModel {
//   final String username;
//   final String password;
//   final String remember;
//   final bool isMobile;
//
//   LoginModel(
//       {required this.username,
//         required this.password,
//         required this.remember,
//         required this.isMobile});
//
//   factory LoginModel.fromJson(Map<String, dynamic> json) {
//     return LoginModel(
//         username: json['username'],
//         password: json['password'],
//         remember: json['remember'],
//         isMobile: json['isMobile']);
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'username': username,
//       'password': password,
//       'remember': remember,
//       'isMobile': isMobile
//     };
//   }
// }
