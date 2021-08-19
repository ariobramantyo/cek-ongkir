class City {
  String cityId;
  String provinceId;
  String province;
  String type;
  String cityName;

  City({
    required this.cityId,
    required this.provinceId,
    required this.province,
    required this.type,
    required this.cityName,
  });

  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      cityId: map['city_id'],
      provinceId: map['province_id'],
      province: map['province'],
      type: map['type'],
      cityName: map['city_name'],
    );
  }
}
