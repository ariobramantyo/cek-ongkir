import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OngkirController extends GetxController {
  var sourceProvinceIsSelected = false.obs;
  var destinationProvinceIsSelected = false.obs;
  var sourceCityIsSelected = false.obs;
  var destinationCityIsSelected = false.obs;

  var sourceProvinceId = '0'.obs;
  var destinationProvinceId = '0'.obs;

  var weigthType = 'gram'.obs;

  var courierIsSelected = false.obs;
  var courier = ''.obs;

  late TextEditingController weigthController;

  @override
  void onInit() {
    weigthController = TextEditingController();
    super.onInit();
  }
}
