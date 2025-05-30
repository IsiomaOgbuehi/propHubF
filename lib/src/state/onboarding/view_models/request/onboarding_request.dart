class OnBoardingRequest {
  final String firstname;
  final String? middleName;
  final String lastname;
  final String gender;
  final String phone;
  final String email;
  final String address;
  final String password;
  final String state;
  final String lga;
  final String agentType;

  const OnBoardingRequest(
      {required this.firstname,
      this.middleName,
      required this.lastname,
      required this.gender,
      required this.phone,
      required this.email,
      required this.address,
      required this.password,
      required this.state,
      required this.lga,
      required this.agentType});

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "middlename": middleName,
        "lastname": lastname,
        "gender": gender,
        "phone": phone,
        "businessAddress": address,
        "email": email,
        "password": password,
        "lga": lga,
        "state": state,
        "userType": agentType
      };
}
