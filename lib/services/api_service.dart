import 'dart:convert';

import 'package:cek_ongkir/models/city.dart';
import 'package:cek_ongkir/models/cost.dart';
import 'package:cek_ongkir/models/province.dart';
import 'package:cek_ongkir/utility.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<Province>> getProvince() async {
    try {
      Uri url = Uri.parse('https://api.rajaongkir.com/starter/province');

      var response = await http.get(url, headers: {'key': Utils.apiKey});

      List<dynamic> data = jsonDecode(response.body)['rajaongkir']['results'];

      List<Province> listProvince =
          data.map((e) => Province.fromMap(e)).toList();

      return listProvince;
    } catch (e) {
      Get.defaultDialog(
        title: 'Terjadi Kesalahan',
        middleText: 'Cek ongkir gagal, cobalah beberapa saat lagi',
        textCancel: 'Close',
        onCancel: () => Get.back(),
      );
      throw Exception();
    }
  }

  static Future<List<City>> getCity(String provinceId) async {
    try {
      Uri url = Uri.parse(
          'https://api.rajaongkir.com/starter/city?province=$provinceId');

      var response = await http.get(url, headers: {'key': Utils.apiKey});

      List<dynamic> data = jsonDecode(response.body)['rajaongkir']['results'];

      List<City> listCity = data.map((e) => City.fromMap(e)).toList();

      return listCity;
    } catch (e) {
      Get.defaultDialog(
        title: 'Terjadi Kesalahan',
        middleText: 'Cek ongkir gagal, cobalah beberapa saat lagi',
        textCancel: 'Close',
        onCancel: () => Get.back(),
      );
      throw Exception();
    }
  }

  static Future<List<Results>> getOngkir(String idKotaAsal, String idKotaTujuan,
      String berat, String kurir) async {
    try {
      EasyLoading.show(status: 'loading...');

      Uri url = Uri.parse('https://api.rajaongkir.com/starter/cost');

      var response = await http.post(
        url,
        headers: {
          'key': Utils.apiKey,
          'content-type': 'application/x-www-form-urlencoded',
        },
        body: {
          'origin': idKotaAsal,
          'destination': idKotaTujuan,
          'weight': berat,
          'courier': kurir,
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)['rajaongkir']['results'];

        List<Results> listResults =
            data.map((e) => Results.fromMap(e)).toList();

        EasyLoading.dismiss();

        return listResults;
      } else {
        EasyLoading.dismiss();

        return List<Results>.empty();
      }
    } catch (e) {
      Get.defaultDialog(
        title: 'Terjadi Kesalahan',
        middleText: 'Cek ongkir gagal, cobalah beberapa saat lagi',
        textCancel: 'Close',
        onCancel: () => Get.back(),
      );
      throw Exception();
    }
  }
}
