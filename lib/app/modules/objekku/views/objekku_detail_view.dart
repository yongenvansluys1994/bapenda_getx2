import 'package:bapenda_getx2/app/routes/app_pages.dart';
import 'package:bapenda_getx2/widgets/logger.dart';
import 'package:bapenda_getx2/widgets/shimmer.dart';
import 'package:bapenda_getx2/widgets/texts.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:bapenda_getx2/widgets/utils/helper/responsive_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';

import '../controllers/objekku_detail_controller.dart';

class ObjekkuDetailView extends StatefulWidget {
  const ObjekkuDetailView({Key? key}) : super(key: key);

  @override
  _ObjekkuDetailViewState createState() => _ObjekkuDetailViewState();
}

class _ObjekkuDetailViewState extends State<ObjekkuDetailView> {
  final controller = Get.find<ObjekkuDetailController>();

  bool buttonsalin = false;

  @override
  void initState() {
    super.initState();
  }

  List<Step> stepList() => [
        Step(
          state: controller.activeStepIndex <= 0
              ? StepState.editing
              : StepState.complete,
          isActive: controller.activeStepIndex >= 0,
          title: Text(
            'USAHA',
            style:
                TextStyle(fontSize: ResponsiveHelper.isTablet() ? 10.sp : null),
          ),
          content: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      offset: Offset(8, 6),
                      color: lightGreenColor.withOpacity(0.3)),
                  BoxShadow(
                      blurRadius: 10,
                      offset: Offset(-1, -5),
                      color: lightGreenColor.withOpacity(0.3))
                ]),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Texts.body2("Nama Usaha :"),
                    ),
                    Container(
                      child: TextFormField(
                        style: TextStyle(fontSize: 12.sp),
                        controller: controller.nama_usaha,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              EdgeInsets.fromLTRB(20.r, 20.r, 20.r, 0),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: '',
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: lightGreenColor, width: 2),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 164, 186, 206),
                          blurRadius: 5,
                        ),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Texts.body2("Alamat :"),
                        ],
                      ),
                    ),
                    Container(
                      child: TextFormField(
                        style: TextStyle(fontSize: 12.sp),
                        controller: controller.alamat_usaha,
                        minLines:
                            2, // any number you need (It works as the rows for the textarea)
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              EdgeInsets.fromLTRB(20.r, 20.r, 20.r, 0),
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: lightGreenColor, width: 2),
                          ),
                        ),
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return "Data harus diisi";
                        //   } else {
                        //     return null;
                        //   }
                        // },
                      ),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 164, 186, 206),
                          blurRadius: 5,
                        ),
                      ]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Texts.body2("RT :"),
                              ),
                              Container(
                                child: TextFormField(
                                  style: TextStyle(fontSize: 12.sp),
                                  controller: controller.rt_usaha,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.r, 20.r, 20.r, 0),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: '',
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 251, 161, 161),
                                          width: 2.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGreenColor, width: 2),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Texts.body2("Kota :"),
                              ),
                              Container(
                                child: TextFormField(
                                  style: TextStyle(fontSize: 12.sp),
                                  controller: controller.kota_usaha,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.r, 20.r, 20.r, 0),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: '',
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 251, 161, 161),
                                          width: 2.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGreenColor, width: 2),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Texts.body2("Kelurahan :"),
                                  ],
                                ),
                              ),
                              Container(
                                child: InputDecorator(
                                  decoration: InputDecoration(
                                    enabled: true,
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.r, 20.r, 20.r, 0),
                                    fillColor:
                                        Color.fromARGB(255, 238, 238, 238),
                                    filled: true,
                                    hintText: '',
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 0.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGreenColor, width: 2),
                                    ),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: controller.ValueKelurahan,
                                      isDense: true,
                                      isExpanded: true,
                                      onChanged: (String? newValue) {
                                        // setState(() {
                                        //   ValueKelurahan = newValue!;
                                        // });
                                      },
                                      items: <String>[
                                        'LUAR KOTA',
                                        'LOK TUAN',
                                        'BONTANG BARU',
                                        'BONTANG KUALA',
                                        'API-API',
                                        'GUNUNG ELAI',
                                        'GUNTUNG',
                                        'TANJUNG LAUT',
                                        'SATIMPO',
                                        'BERBAS TENGAH',
                                        'BERBAS PANTAI',
                                        'BONTANG LESTARI',
                                        'TJ. LAUT INDAH',
                                        'BELIMBING',
                                        'TELIHAN',
                                        'KANAAN',
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(fontSize: 10.5.sp),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Texts.body2("Kecamatan :"),
                                  ],
                                ),
                              ),
                              Container(
                                child: InputDecorator(
                                  decoration: InputDecoration(
                                    enabled: true,
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.r, 20.r, 20.r, 0),
                                    fillColor:
                                        Color.fromARGB(255, 238, 238, 238),
                                    filled: true,
                                    hintText: '',
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 0.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGreenColor, width: 2),
                                    ),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: controller.ValueKecamatan,
                                      isDense: true,
                                      isExpanded: true,
                                      onChanged: (String? newValue) {
                                        // setState(() {
                                        //   ValueKecamatan = newValue!;
                                        // });
                                      },
                                      items: <String>[
                                        'LUAR KOTA',
                                        'BONTANG UTARA',
                                        'BONTANG SELATAN',
                                        'BONTANG BARAT',
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(fontSize: 10.5.sp),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Texts.body2("No HP :"),
                              ),
                              Container(
                                child: TextFormField(
                                  style: TextStyle(fontSize: 12.sp),
                                  controller: controller.nohp_usaha,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.r, 20.r, 20.r, 0),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: '',
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 251, 161, 161),
                                          width: 2.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGreenColor, width: 2),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Texts.body2("Email :"),
                              ),
                              Container(
                                child: TextFormField(
                                  style: TextStyle(fontSize: 12.sp),
                                  controller: controller.email_usaha,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.r, 20.r, 20.r, 0),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: '',
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 251, 161, 161),
                                          width: 2.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGreenColor, width: 2),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Step(
          state: controller.activeStepIndex <= 1
              ? StepState.editing
              : StepState.complete,
          isActive: controller.activeStepIndex >= 1,
          title: Text('PEMILIK',
              style: TextStyle(
                  fontSize: ResponsiveHelper.isTablet() ? 10.sp : null)),
          content: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      offset: Offset(8, 6),
                      color: lightGreenColor.withOpacity(0.3)),
                  BoxShadow(
                      blurRadius: 10,
                      offset: Offset(-1, -5),
                      color: lightGreenColor.withOpacity(0.3))
                ]),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Texts.body2("Nama Pemilik/Pengelola :"),
                        ),
                      ],
                    ),
                    Container(
                      child: TextFormField(
                        style: TextStyle(fontSize: 12.sp),
                        controller: controller.nama_pemilik,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              EdgeInsets.fromLTRB(20.r, 20.r, 20.r, 0),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: '',
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: lightGreenColor, width: 2),
                          ),
                        ),
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return "Data harus diisi";
                        //   } else {
                        //     return null;
                        //   }
                        // },
                      ),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 164, 186, 206),
                          blurRadius: 5,
                        ),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Texts.body2("Pekerjaan/Jabatan :"),
                    ),
                    Container(
                      child: TextFormField(
                        style: TextStyle(fontSize: 12.sp),
                        controller: controller.pekerjaan_pemilik,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              EdgeInsets.fromLTRB(20.r, 20.r, 20.r, 0),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: '',
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 251, 161, 161),
                                width: 2.0),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: lightGreenColor, width: 2),
                          ),
                        ),
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return "Data harus diisi";
                        //   } else {
                        //     return null;
                        //   }
                        // },
                      ),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 164, 186, 206),
                          blurRadius: 5,
                        ),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Texts.body2("Alamat :"),
                        ],
                      ),
                    ),
                    Container(
                      child: TextFormField(
                        style: TextStyle(fontSize: 12.sp),
                        controller: controller.alamat_pemilik,
                        minLines:
                            3, // any number you need (It works as the rows for the textarea)
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              EdgeInsets.fromLTRB(12.r, 12.r, 12.r, 0),
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: lightGreenColor, width: 2),
                          ),
                        ),
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return "Data harus diisi";
                        //   } else {
                        //     return null;
                        //   }
                        // },
                      ),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 164, 186, 206),
                          blurRadius: 5,
                        ),
                      ]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Texts.body2("RT"),
                              ),
                              Container(
                                child: TextFormField(
                                  style: TextStyle(fontSize: 12.sp),
                                  controller: controller.rt_pemilik,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.r, 20.r, 20.r, 0),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: '',
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 251, 161, 161),
                                          width: 2.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGreenColor, width: 2),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Texts.body2("Kota :"),
                              ),
                              Container(
                                child: TextFormField(
                                  style: TextStyle(fontSize: 12.sp),
                                  controller: controller.kota_pemilik,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.r, 20.r, 20.r, 0),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: '',
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 251, 161, 161),
                                          width: 2.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGreenColor, width: 2),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Texts.body2("Kelurahan :"),
                                  ],
                                ),
                              ),
                              Container(
                                child: TextFormField(
                                  style: TextStyle(fontSize: 12.sp),
                                  controller: controller.kel_pemilik,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.r, 20.r, 20.r, 0),
                                    fillColor: Colors.white,
                                    filled: true,
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 0.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGreenColor, width: 2),
                                    ),
                                  ),
                                  // validator: (value) {
                                  //   if (value == null || value.isEmpty) {
                                  //     return "Data harus diisi";
                                  //   } else {
                                  //     return null;
                                  //   }
                                  // },
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Texts.body2("Kecamatan :"),
                                  ],
                                ),
                              ),
                              Container(
                                child: TextFormField(
                                  style: TextStyle(fontSize: 12.sp),
                                  controller: controller.kec_pemilik,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.r, 20.r, 20.r, 0),
                                    fillColor: Colors.white,
                                    filled: true,
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 0.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGreenColor, width: 2),
                                    ),
                                  ),
                                  // validator: (value) {
                                  //   if (value == null || value.isEmpty) {
                                  //     return "Data harus diisi";
                                  //   } else {
                                  //     return null;
                                  //   }
                                  // },
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Texts.body2("No HP :"),
                              ),
                              Container(
                                child: TextFormField(
                                  style: TextStyle(fontSize: 12.sp),
                                  controller: controller.nohp_pemilik,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.r, 20.r, 20.r, 0),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: '',
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 251, 161, 161),
                                          width: 2.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGreenColor, width: 2),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Texts.body2("Email :"),
                              ),
                              Container(
                                child: TextFormField(
                                  style: TextStyle(fontSize: 12.sp),
                                  controller: controller.email_pemilik,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.r, 20.r, 20.r, 0),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: '',
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 251, 161, 161),
                                          width: 2.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGreenColor, width: 2),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Center(child: Texts.body2("Upload KTP :")),
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(Routes.DETAILSCREEN,
                                    arguments:
                                        controller.dataArgument.imageKtp);
                              },
                              child: ClipRRect(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "https://yongen-bisa.com/bapenda_app/upload/${controller.dataArgument.imageKtp}",
                                  width: 80,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      ShimmerWidget.rectangular(
                                    width: 80.h,
                                    height: 60.h,
                                    baseColor: shadowColor,
                                  ),
                                  errorWidget: ((context, url, error) =>
                                      Image.asset(
                                        'images/image.png',
                                        fit: BoxFit.cover,
                                        width: 80.h,
                                        height: 60.h,
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child:
                                    Center(child: Texts.body2("Upload NPWP :")),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.DETAILSCREEN,
                                      arguments:
                                          controller.dataArgument.imageNpwp);
                                },
                                child: ClipRRect(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "https://yongen-bisa.com/bapenda_app/upload/${controller.dataArgument.imageNpwp}",
                                    width: 80,
                                    height: 60,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        ShimmerWidget.rectangular(
                                      width: 80.h,
                                      height: 60.h,
                                      baseColor: shadowColor,
                                    ),
                                    errorWidget: ((context, url, error) =>
                                        Image.asset(
                                          'images/image.png',
                                          fit: BoxFit.cover,
                                          width: 80.h,
                                          height: 60.h,
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Step(
          state: StepState.complete,
          isActive: controller.activeStepIndex >= 2,
          title: Text('LOKASI',
              style: TextStyle(
                  fontSize: ResponsiveHelper.isTablet() ? 10.sp : null)),
          content: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      offset: Offset(8, 6),
                      color: lightGreenColor.withOpacity(0.3)),
                  BoxShadow(
                      blurRadius: 10,
                      offset: Offset(-1, -5),
                      color: lightGreenColor.withOpacity(0.3))
                ]),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    "Titik Lokasi Objek Pajak ",
                    style: TextStyle(
                        color: MainColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  GetBuilder<ObjekkuDetailController>(
                    init: ObjekkuDetailController(),
                    builder: (controller) {
                      return SizedBox(
                        height: 400.h,
                        child: controller.lat == null
                            ? SizedBox()
                            : GoogleMap(
                                markers: controller.markers2,
                                mapType: MapType.hybrid,
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(
                                      controller.lat == null
                                          ? 0.13295280196348974
                                          : controller.lat!,
                                      controller.long == null
                                          ? 117.47944742888573
                                          : controller.long!),
                                  zoom: 18,
                                ),
                                onMapCreated:
                                    (GoogleMapController controllers) {
                                  controller.addMarkers();
                                },
                              ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        )
      ];
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        extendBodyBehindAppBar: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: MainColor //change your color here
              ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Data Wajib Pajak",
            style: TextStyle(
                color: MainColor,
                fontSize: ResponsiveHelper.isTablet() ? 11.sp : null),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 7),
              child: PopupMenuButton(
                  // add icon, by default "3 dot" icon
                  icon: const Icon(
                    Icons.account_circle,
                    color: textColor,
                    size: 41,
                  ),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem<int>(
                        value: 0,
                        child: Text("My Profile"),
                      ),
                      PopupMenuItem<int>(
                        value: 1,
                        child: Text("Logout"),
                      ),
                    ];
                  },
                  onSelected: (value) {
                    if (value == 0) {
                      logInfo("My account menu is selected.");
                    } else if (value == 1) {}
                  }),
            ),
          ],
        ),
        body: GestureDetector(
          child: PageView(
            controller: controller.pageController,
            onPageChanged: (int page) {
              controller.currentPage = page;
              controller.swipePage();
            },
            children: [
              Stack(
                children: [
                  GetBuilder<ObjekkuDetailController>(
                    init: ObjekkuDetailController(),
                    builder: (controller) {
                      return Stepper(
                        type: StepperType.horizontal,
                        currentStep: controller.activeStepIndex,
                        steps: stepList(),
                        onStepContinue: () {
                          if (controller.activeStepIndex <
                              (stepList().length - 1)) {
                            setState(() {
                              controller.activeStepIndex += 1;
                            });
                          } else {
                            print('Submited');
                          }
                        },
                        onStepCancel: () {
                          if (controller.activeStepIndex == 0) {
                            return;
                          }
                          setState(() {
                            controller.activeStepIndex -= 1;
                          });
                        },
                        onStepTapped: (int index) {
                          setState(() {
                            controller.activeStepIndex = index;
                          });
                        },
                        controlsBuilder:
                            (BuildContext context, ControlsDetails controls) {
                           
                          return SizedBox();
                        },
                      );
                    },
                  ),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       controller.visibleswpe();
                  //     },
                  //     child: Text("Test"))
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}

class swipeLeft extends StatelessWidget {
  final ObjekkuDetailController controller;
  const swipeLeft({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ObjekkuDetailController>(
      init: ObjekkuDetailController(),
      builder: (controller) {
        return Positioned(
          right: 0,
          bottom: 35.r,
          child: AnimatedOpacity(
            curve: Curves.linear,
            opacity: controller.isVisibleSwipe ? 1.0 : 0.0,
            duration: Duration(milliseconds: 700),
            child: Container(
              height: 110.h,
              width: 130.w,
              child: Stack(
                children: [
                  Positioned(
                    top: 30.h,
                    right: 0,
                    child: Container(
                      height: Get.width * 0.085,
                      width: 120.w,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: gradientColor),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(48),
                            bottomLeft: Radius.circular(48),
                            bottomRight: Radius.circular(7),
                            topRight: Radius.circular(7),
                          ),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 7,
                                offset: Offset(5, 5),
                                color: lightBlueColor.withOpacity(0.4)),
                            BoxShadow(
                                blurRadius: 7,
                                offset: Offset(-2, -2),
                                color: lightBlueColor.withOpacity(0.4))
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Texts.captionSm("Riwayat",
                                  textAlign: TextAlign.right,
                                  color: Colors.white),
                              Texts.captionSm("Pembayaran ",
                                  textAlign: TextAlign.right,
                                  color: Colors.white),
                            ],
                          ),
                          SizedBox(
                            width: 3.w,
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 7.r,
                    left: 7.r,
                    child: SizedBox(
                        child: Lottie.asset('assets/lottie/swipeleft.json',
                            fit: BoxFit.fill, height: 65.h)),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


