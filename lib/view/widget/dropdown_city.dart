import 'package:cek_ongkir/controller/ongkir_controller.dart';
import 'package:cek_ongkir/models/city.dart';
import 'package:cek_ongkir/services/api_service.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropdownCity extends StatelessWidget {
  // const DropdownCity({ Key? key }) : super(key: key);

  final String provinceId;
  final String type;

  DropdownCity({Key? key, required this.provinceId, required this.type})
      : super(key: key);

  final ongkirController = Get.find<OngkirController>();

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<City>(
      label: 'Kota/Kabupaten',
      dropdownSearchDecoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
      onFind: (_) async {
        return await ApiService().getCity(provinceId);
      },
      itemAsString: (City city) {
        return city.cityName;
      },
      onChanged: (City? data) {
        if (data != null) {
          if (type == 'asal') {
            ongkirController.sourceCityIsSelected.value = true;
          } else {
            ongkirController.destinationCityIsSelected.value = true;
          }
        } else {
          if (type == 'asal') {
            ongkirController.sourceCityIsSelected.value = false;
          } else {
            ongkirController.destinationCityIsSelected.value = false;
          }
        }
        print(data!.cityName);
      },
    );
  }
}
