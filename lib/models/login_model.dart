class LoginModel {
  final String username;
  final String password;
  final String remember;
  final bool isMobile;

  LoginModel(
      {required this.username,
      required this.password,
      required this.remember,
      required this.isMobile});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
        username: json['username'],
        password: json['password'],
        remember: json['remember'],
        isMobile: json['isMobile']);
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'remember': remember,
      'isMobile': isMobile
    };
  }
}
