class User {
  late String firstName;
  late String lastName;
  late String email;
  late String mobileNumber;
  late String password;
  late String deviceType;
  late String macId;
  late String serialNumber;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobileNumber,
    required this.password,
    required this.deviceType,
    required this.macId,
    required this.serialNumber,
  });
   Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'mobile': mobileNumber,
      'password': password,
      'device_type': "android",
      'mac_id': "1234567899",
      'serial_number': "1234",
      
    };
    
   }
   }