class UserResponse {
  final String userId;
  final String firstname;
  final String middlename;
  final String lastname;
  final String gender;
  final String phone;
  final String address;
  final String email;
  final String lga;
  final String state;
  final String userType;
  final bool isActive;
  final String? createdAt;
  final String? socketId;

  UserResponse(
      {required this.userId,
      required this.firstname,
      required this.middlename,
      required this.lastname,
      required this.gender,
      required this.phone,
      required this.address,
      required this.email,
      required this.lga,
      required this.state,
      required this.userType,
      required this.isActive,
      this.createdAt,
      this.socketId});

  factory UserResponse.init() => UserResponse(
      userId: '',
      firstname: '',
      middlename: '',
      lastname: '',
      gender: '',
      phone: '',
      address: '',
      email: '',
      lga: '',
      state: '',
      userType: '',
      isActive: false);

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
      userId: json['_id'] ?? '',
      firstname: json['firstname'] ?? '',
      middlename: json['middlename'] ?? '',
      lastname: json['lastname'] ?? '',
      gender: json['gender'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      email: json['email'] ?? '',
      lga: json['lga'] ?? '',
      state: json['state'] ?? '',
      userType: json['userType'] ?? '',
      isActive: json['isActive'] ?? false,
      socketId: json['socketId']);
}
