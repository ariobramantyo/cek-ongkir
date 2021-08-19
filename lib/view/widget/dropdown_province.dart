import 'package:cek_ongkir/controller/ongkir_controller.dart';
import 'package:cek_ongkir/models/province.dart';
import 'package:cek_ongkir/services/api_service.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropdownProvince extends StatelessWidget {
  // const DropdownProvince({Key? key}) : super(key: key);
  final String type;

  DropdownProvince({Key? key, required this.type}) : super(key: key);

  final ongkirController = Get.find<OngkirController>();

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Province>(
      label: type == 'asal' ? 'Provinsi Asal' : 'Provinsi Tujuan',
      dropdownSearchDecoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
      onFind: (_) async {
        return await ApiService().getProvince();
      },
      itemAsString: (Province province) {
        return province.province;
      },
      onChanged: (Province? data) {
        if (data != null) {
          if (type == 'asal') {
            ongkirController.sourceProvinceId.value = data.provinceId;
            ongkirController.sourceProvinceIsSelected.value = true;
          } else {
            ongkirController.destinationProvinceId.value = data.provinceId;
            ongkirController.destinationProvinceIsSelected.value = true;
          }
        } else {
          if (type == 'asal') {
            ongkirController.sourceProvinceId.value = '0';
            ongkirController.sourceProvinceIsSelected.value = false;
          } else {
            ongkirController.destinationProvinceId.value = 'o';
            ongkirController.destinationProvinceIsSelected.value = false;
          }
        }

        print(data!.province);
      },
    );
  }
}
