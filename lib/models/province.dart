class Province {
  String provinceId;
  String province;

  Province({required this.provinceId, required this.province});

  factory Province.fromMap(Map<String, dynamic> map) {
    return Province(provinceId: map['province_id'], province: map['province']);
  }
}
