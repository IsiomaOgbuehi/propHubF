class PersonalDetailModel {
  final String firstName;
  final String? middleName;
  final String lastName;
  final String gender;

  PersonalDetailModel({
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.gender
});

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'middleName': middleName,
    'lastName': lastName,
    'gender': gender
  };
}