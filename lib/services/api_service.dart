import 'dart:convert';

import 'package:cek_ongkir/models/city.dart';
import 'package:cek_ongkir/models/province.dart';
import 'package:cek_ongkir/utility.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<Province>> getProvince() async {
    Uri url = Uri.parse('https://api.rajaongkir.com/starter/province');

    var response = await http.get(url, headers: {'key': Utils.apiKey});

    List<dynamic> data = jsonDecode(response.body)['rajaongkir']['results'];

    List<Province> listProvince = data.map((e) => Province.fromMap(e)).toList();

    return listProvince;
  }

  Future<List<City>> getCity(String provinceId) async {
    Uri url = Uri.parse(
        'https://api.rajaongkir.com/starter/city?province=$provinceId');

    var response = await http.get(url, headers: {'key': Utils.apiKey});

    List<dynamic> data = jsonDecode(response.body)['rajaongkir']['results'];

    List<City> listCity = data.map((e) => City.fromMap(e)).toList();

    return listCity;
  }
}
