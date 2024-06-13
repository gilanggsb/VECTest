class LoginModel {
  final String password;
  final String phoneNumber;
  final String countryCode;

  LoginModel({
    required this.password,
    required this.phoneNumber,
    required this.countryCode,
  });

  Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber,
        "country_code": countryCode,
        "password": password,
      };
}
