class UserRegistration {
  final String fullName;
  final String email;
  final String zipcode;
  final String password;
  final String selectedLanguage;
  final bool checkTermConditions;

  UserRegistration({
    required this.fullName,
    required this.email,
    required this.zipcode,
    required this.password,
    required this.selectedLanguage,
    required this.checkTermConditions,
  });

  factory UserRegistration.fromJson(Map<String, dynamic> json) {
    return UserRegistration(
      fullName: json['fullName'],
      email: json['email'],
      zipcode: json['zipcode'],
      password: json['password'],
      selectedLanguage: json['selectedLanguage'],
      checkTermConditions: json['checkTermConditions'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'zipcode': zipcode,
      'password': password,
      'selectedLanguage': selectedLanguage,
      'checkTermConditions': checkTermConditions,
    };
  }
}
