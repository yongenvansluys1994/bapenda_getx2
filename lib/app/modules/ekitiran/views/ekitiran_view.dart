import 'package:bapenda_getx2/widgets/buttons.dart';
import 'package:bapenda_getx2/widgets/custom_appbar.dart';
import 'package:bapenda_getx2/widgets/text_fields.dart';
import 'package:bapenda_getx2/widgets/texts.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/ekitiran_controller.dart';

class EkitiranView extends GetView<EkitiranController> {
  const EkitiranView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "E-Kitiran PBB RT",
        leading: true,
        isLogin: true,
      ),
      //   body: SingleChildScrollView(
      //   child: GetBuilder<EkitiranController>(
      //     init: EkitiranController(),
      //     builder: (controller) {
      //       return Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: Stack(
      //             children: [
      //               Column(
      //                 children: [
      //                   TextFields.defaultTextFieldSuggest(
      //                     title: "Cari Nama WP",
      //                     hintText: "Pencarian Pintar data WP..",
      //                     controller: controller.nama_cari,
      //                     isLoading: controller.isLoadingSuggest,
      //                     textInputAction: TextInputAction.next,
      //                     textInputType: TextInputType.text,
      //                     borderColor: primaryColor,
      //                     validator: true,

      //                     onChanged: (value) => controller
      //                         .onTextChanged(value), // Fetch saat mengetik
      //                   ),
      //                   // TextField atau widget lainnya di bawah
      //                   Row(
      //                     children: [
      //                       Container(
      //                         width: 167.w,
      //                         child: TextFields.defaultTextField2(
      //                           title: "NPWPD",
      //                           readOnly: true,
      //                           controller: controller.npwpd,
      //                           isLoading: controller.isLoadingSuggest,
      //                           textInputAction: TextInputAction.next,
      //                           textInputType: TextInputType.number,
      //                           // prefixIcon: Icons.contact_emergency,
      //                           borderColor: primaryColor,
      //                           validator: true,
      //                         ),
      //                       ),
      //                       SizedBox(width: 10.w),
      //                       Container(
      //                         width: 167.w,
      //                         child: TextFields.defaultTextField2(
      //                           title: "Jenis Pajak",
      //                           controller: controller.jenispajak,
      //                           readOnly: true,
      //                           isLoading: controller.isLoadingSuggest,
      //                           textInputAction: TextInputAction.next,
      //                           textInputType: TextInputType.text,
      //                           // prefixIcon: Icons.contact_emergency,
      //                           borderColor: primaryColor,
      //                           validator: true,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                   TextFields.defaultTextField2(
      //                     title: "Alamat",
      //                     controller: controller.alamat,
      //                     readOnly: true,
      //                     isLoading: controller.isLoadingSuggest,
      //                     textInputAction: TextInputAction.next,
      //                     textInputType: TextInputType.multiline,
      //                     // prefixIcon: Icons.contact_emergency,
      //                     borderColor: primaryColor,
      //                     validator: true,
      //                   ),
      //                   Row(
      //                     children: [
      //                       Container(
      //                         width: 167.w,
      //                         child: TextFields.defaultTextField2(
      //                           title: "Kelurahan",
      //                           readOnly: true,
      //                           controller: controller.kelurahan,
      //                           isLoading: controller.isLoadingSuggest,
      //                           textInputAction: TextInputAction.next,
      //                           textInputType: TextInputType.text,
      //                           // prefixIcon: Icons.contact_emergency,
      //                           borderColor: primaryColor,
      //                           validator: true,
      //                         ),
      //                       ),
      //                       SizedBox(width: 10.w),
      //                       Container(
      //                         width: 167.w,
      //                         child: TextFields.defaultTextField2(
      //                           title: "Kecamatan",
      //                           readOnly: true,
      //                           controller: controller.kecamatan,
      //                           isLoading: controller.isLoadingSuggest,
      //                           textInputAction: TextInputAction.next,
      //                           textInputType: TextInputType.text,
      //                           // prefixIcon: Icons.contact_emergency,
      //                           borderColor: primaryColor,
      //                           validator: true,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                   TextFields.textFieldDropdown(
      //                     textInputAction: TextInputAction.next,
      //                     textInputType: TextInputType.text,
      //                     isLoading: false,
      //                     controller: controller.jenisreporting,
      //                     hintText: "Pilih Jenis Reporting",
      //                     title: "Pilih Jenis Reporting",
      //                     isDropdown: true,
      //                     dropdownItems: [
      //                       'Pendataan Wajib Pajak',
      //                       'Validasi Wajib Pajak',
      //                       'Penyampaian SKPD',
      //                       'Penagihan',
      //                     ],
      //                     dropdownValue: controller.jenisreporting.text.isEmpty
      //                         ? null
      //                         : controller.jenisreporting.text,
      //                     onDropdownChanged: (newValue) {
      //                       controller.changeValueJenisReporting(newValue);
      //                     },
      //                     validator: true,
      //                   ),
      //                   TextFields.textFieldMultiline(
      //                     title: "Keterangan Reporting",
      //                     hintText: "Masukkan Keterangan Reporting ..",
      //                     controller: controller.keterangan,
      //                     isLoading: controller.isLoadingSuggest,
      //                     textInputAction: TextInputAction.next,
      //                     textInputType: TextInputType.text,
      //                     // prefixIcon: Icons.contact_emergency,
      //                     borderColor: primaryColor,
      //                     validator: true,
      //                     borderRed: true,
      //                   ),
      //                   Column(
      //                     crossAxisAlignment: CrossAxisAlignment.center,
      //                     children: [
      //                       Padding(
      //                         padding: const EdgeInsets.all(8),
      //                         child: Center(
      //                             child:
      //                                 Texts.body2("Upload Foto Dokumentasi :")),
      //                       ),
      //                       Container(
      //                         child: (controller.imageFile == null)
      //                             ? Image.asset(
      //                                 'assets/images/image.png',
      //                                 fit: BoxFit.contain,
      //                               )
      //                             : Image.file(
      //                                 fit: BoxFit.contain,
      //                                 File(controller.imageFile!.path)),
      //                         width: 240.w,
      //                         height: 120.h,
      //                         decoration: BoxDecoration(
      //                             borderRadius: BorderRadius.circular(9.w),
      //                             border: Border.all(
      //                                 width: 1, color: MainColorGreen)),
      //                       ),
      //                       SizedBox(height: 5.h),
      //                       SizedBox(
      //                         width: 128.w,
      //                         height: 33.h,
      //                         child: ElevatedButton(
      //                           onPressed: () {
      //                             controller.showChoiceDialog(context);
      //                           },
      //                           style: ButtonStyle(
      //                             backgroundColor:
      //                                 MaterialStateProperty.all<Color>(
      //                                     Color.fromARGB(255, 64, 64, 64)),
      //                           ),
      //                           child: Row(
      //                             children: [
      //                               Icon(Icons.camera_alt, size: 20),
      //                               SizedBox(
      //                                 width: 8,
      //                               ),
      //                               Text(
      //                                 'Pilih Gambar',
      //                                 style: TextStyle(fontSize: 13),
      //                               )
      //                             ],
      //                           ),
      //                         ),
      //                       ),
      //                       SizedBox(height: 15.h),
      //                       SizedBox(
      //                         width: 200.w,
      //                         child: Buttons.gradientButton(
      //                           handler: () =>
      //                               controller.showChoiceDialog(context),
      //                           widget: Texts.button("Simpan Data"),
      //                           borderSide: false,
      //                           gradient: [Colors.cyan, Colors.indigo],
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ],
      //               ),
      //               if (controller.suggestions.isNotEmpty)
      //                 Positioned(
      //                   left: 0,
      //                   right: 0,
      //                   top: 65, // Posisi dropdown di bawah TextField
      //                   child: Material(
      //                     elevation: 4,
      //                     borderRadius: BorderRadius.circular(8),
      //                     child: Container(
      //                       height: 60.h * controller.suggestions.length,
      //                       child: ListView.builder(
      //                         itemCount: controller.suggestions.length,
      //                         itemBuilder: (context, index) {
      //                           final suggestion =
      //                               controller.suggestions[index];
      //                           return ListTile(
      //                             title: Text(suggestion['nama_usaha'] ?? ''),
      //                             subtitle: Text(
      //                                 'NPWPD: ${suggestion['npwpd'] ?? ''}\nAlamat: ${suggestion['alamat_usaha'] ?? ''}'),
      //                             onTap: () {
      //                               controller.nama.text =
      //                                   suggestion['nama_usaha']!;
      //                               controller.npwpd.text =
      //                                   suggestion['npwpd']!;
      //                               controller.alamat.text =
      //                                   suggestion['alamat_usaha']!;
      //                               controller.removeSuggestList();
      //                             },
      //                           );
      //                         },
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //             ],
      //           ));
      //     },
      //   ),
      // ),
    );
  }
}
