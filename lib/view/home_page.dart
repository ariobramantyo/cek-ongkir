import 'package:cek_ongkir/controller/ongkir_controller.dart';
import 'package:cek_ongkir/view/widget/dropdown_city.dart';
import 'package:cek_ongkir/view/widget/dropdown_province.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final ongkirController = Get.put(OngkirController());

  bool allSelected() {
    return ongkirController.sourceProvinceIsSelected.value &&
        ongkirController.sourceCityIsSelected.value &&
        ongkirController.destinationProvinceIsSelected.value &&
        ongkirController.destinationCityIsSelected.value &&
        ongkirController.weigthController.text != '' &&
        ongkirController.courierIsSelected.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F5F7),
      appBar: AppBar(
        backgroundColor: Color(0xFF3EBACE),
        title: Text('Cek Ongkir'),
        // centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            SizedBox(height: 20),
            DropdownProvince(
              type: 'asal',
            ),
            Obx(() {
              return ongkirController.sourceProvinceIsSelected.value
                  ? Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: DropdownCity(
                          provinceId: ongkirController.sourceProvinceId.value,
                          type: 'asal'),
                    )
                  : SizedBox();
            }),
            SizedBox(height: 20),
            DropdownProvince(
              type: 'tujuan',
            ),
            Obx(() {
              return ongkirController.destinationProvinceIsSelected.value
                  ? Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: DropdownCity(
                          provinceId:
                              ongkirController.destinationProvinceId.value,
                          type: 'tujuan'),
                    )
                  : SizedBox();
            }),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: ongkirController.weigthController,
                    decoration: InputDecoration(
                      labelText: 'Berat barang',
                      hintText: 'Berat barang',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                SizedBox(width: 10),
                SizedBox(
                  height: 55,
                  width: 100,
                  child: DropdownSearch<String>(
                    mode: Mode.MENU,
                    items: ['gram', 'kg'],
                    selectedItem: 'gram',
                    label: "Berat barang",
                    hint: "Berat barang",
                    popupItemBuilder: (context, item, isSelected) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          item,
                          style: TextStyle(fontSize: 20),
                        ),
                      );
                    },
                    onChanged: (String? type) {
                      ongkirController.weigthType.value = type!;
                    },
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            DropdownSearch<Map<String, dynamic>>(
              mode: Mode.DIALOG,
              items: [
                {'code': 'jne', 'name': 'Jalur Nugraha Ekakurir (JNE)'},
                {'code': 'pos', 'name': 'Perusahaan Opsional Surat (POS)'},
                {'code': 'tiki', 'name': 'Titipan Kilat (TIKI)'},
              ],
              label: "Kurir",
              hint: "Kurir",
              dropdownSearchDecoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              popupItemBuilder: (context, item, isSelected) {
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    item['name'],
                    style: TextStyle(fontSize: 20),
                  ),
                );
              },
              itemAsString: (item) {
                return item['name'];
              },
              onChanged: (type) {
                if (type != null) {
                  ongkirController.courier.value = type['code'];
                  ongkirController.courierIsSelected.value = true;
                } else {
                  ongkirController.courierIsSelected.value = false;
                  ongkirController.courier.value = '';
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (allSelected()) {
                  ongkirController.cekOngkir();
                } else {
                  Get.snackbar(
                      'Gagal', 'Cek ongkir gagal, pastikan semua data terisi',
                      snackPosition: SnackPosition.TOP);
                }
              },
              child: Text('Cek ongkir'),
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                primary: Color(0xFF3EBACE),
                fixedSize: Size(double.infinity, 45),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
            // Obx(() {
            //   // if (ongkirController.sourceProvinceIsSelected.value &&
            //   //     ongkirController.sourceCityIsSelected.value &&
            //   //     ongkirController.destinationProvinceIsSelected.value &&
            //   //     ongkirController.destinationCityIsSelected.value &&
            //   //     ongkirController.weigthController.text != '' &&
            //   //     ongkirController.courierIsSelected.value)
            //   //   return Container(
            //   //     height: 50,
            //   //     color: Colors.red,
            //   //   );
            //   // else
            //   //   return Container(
            //   //     height: 50,
            //   //     color: Colors.blue,
            //   //   );
            //   return ElevatedButton(
            //       onPressed: () {
            //         if (allSelected()) {
            //           Get.snackbar('Berhassil',
            //               'Cek ongkir berhasil semua data berhasil terinput');
            //         } else {
            //           Get.snackbar('Gagal',
            //               'Cek ongkir gagal, pastikan semua data terisi');
            //         }
            //       },
            //       child: Text('Cek ongkir'));
            // }),
          ],
        ),
      ),
    );
  }
}
