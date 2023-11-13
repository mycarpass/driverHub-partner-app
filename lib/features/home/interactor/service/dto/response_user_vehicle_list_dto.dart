class ResponseUserVehicleListDto {
  List<ReponseVehicleDataDto> data = [];

  ResponseUserVehicleListDto.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ReponseVehicleDataDto>[];
      json['data'].forEach((v) {
        data.add(ReponseVehicleDataDto.fromJson(v));
      });
    }
  }
}

class ReponseVehicleDataDto {
  int id = 0;
  String name = "";
  String make = "";
  String model = "";
  String color = "";
  String bodyType = "";
  String nickname = "";
  String year = "";
  String licensePlate = "";

  ReponseVehicleDataDto(
      {required this.id,
      required this.name,
      required this.make,
      required this.model,
      required this.color,
      required this.bodyType,
      required this.nickname,
      required this.year,
      required this.licensePlate});

  ReponseVehicleDataDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    make = json['make'];
    model = json['model'];
    color = json['color'];
    bodyType = json['body_type'];
    nickname = json['nickname'];
    year = json['year'];
    licensePlate = json['license_plate'];
  }
}
