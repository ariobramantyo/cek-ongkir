// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:cek_ongkir/models/province.dart';
import 'package:cek_ongkir/utility.dart';
import 'package:http/http.dart' as http;

void main() async {
  Uri url = Uri.parse('https://api.rajaongkir.com/starter/province');

  var response = await http.get(url, headers: {'key': Utils.apiKey});

  List<dynamic> data = jsonDecode(response.body)['rajaongkir']['results'];

  List<Province> listProvince = data.map((e) => Province.fromMap(e)).toList();
  print(listProvince[0].province);
}
