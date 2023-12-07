class CustomerRegisterDto {
  final String name;
  final String plate;
  final String phone;
  String? email;

  CustomerRegisterDto(
      {required this.name, required this.plate, required this.phone});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "car_license_plate": plate,
      "phone": phone,
      "email": email
    };
  }
}
