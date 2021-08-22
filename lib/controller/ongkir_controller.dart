import 'package:cek_ongkir/models/cost.dart';
import 'package:cek_ongkir/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class OngkirController extends GetxController {
  var sourceProvinceIsSelected = false.obs;
  var destinationProvinceIsSelected = false.obs;
  var sourceCityIsSelected = false.obs;
  var destinationCityIsSelected = false.obs;

  var sourceProvinceId = '0'.obs;
  var destinationProvinceId = '0'.obs;
  var sourceCityId = '0'.obs;
  var destinationCityId = '0'.obs;

  var weigthType = 'gram'.obs;

  var courierIsSelected = false.obs;
  var courier = ''.obs;

  late TextEditingController weigthController;

  @override
  void onInit() {
    weigthController = TextEditingController();
    super.onInit();
  }

  String checkWeightType(String value) {
    if (weigthType.value == 'kg') {
      try {
        value = (double.parse(value) * 1000).toString();
      } catch (e) {
        EasyLoading.dismiss();
        Get.defaultDialog(
          title: 'Terjadi kesalahan',
          middleText: 'Gunakan titik untuk penulisan angka desimal',
          textCancel: 'Close',
          onCancel: () => Get.back(),
        );
      }
    }
    print(value);
    return value;
  }

  void cekOngkir() async {
    List<Results> resultList = await ApiService.getOngkir(
      sourceCityId.value,
      destinationCityId.value,
      checkWeightType(weigthController.text),
      courier.value,
    );

    if (resultList.length != 0) {
      var result = resultList[0];
      Get.defaultDialog(
        title: '${result.name}',
        contentPadding: EdgeInsets.all(10),
        content: Column(
          children: result.costs
              .map((e) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${e.description} (${e.service})'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Rp.${e.cost[0].value}',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            courier.value == 'pos'
                                ? e.cost[0].etd
                                : '${e.cost[0].etd} HARI',
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ))
              .toList(),
        ),
        textCancel: 'Close',
        onCancel: () => Get.back(),
      );
    } else {
      Get.defaultDialog(
        title: 'Terjadi Kesalahan',
        middleText: 'Cek ongkir gagal, cobalah beberapa saat lagi',
        textCancel: 'Close',
        onCancel: () => Get.back(),
      );
    }
  }
}
