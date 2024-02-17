import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:bapenda_getx2/widgets/topline_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

addBottomSheet({required BuildContext context}) {
  Get.bottomSheet(
    GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        height: 300.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
            color: Colors.white),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
          child: Form(
            //key: berita_C.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  topline_bottomsheet(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15),
                        Container(
                          child: TextFormField(
                            // controller: berita_C.judul_kegiatanCon,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(12, 12, 12, 0),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Masukkan Nama Usaha',
                              labelText: 'Nama Usaha *',
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 0.0),
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
                        SizedBox(height: 15),
                        Container(
                          child: TextFormField(
                            //controller: berita_C.isi_kegiatanCon,
                            //focusNode: berita_C.focusNode,
                            minLines:
                                3, // any number you need (It works as the rows for the textarea)
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            maxLines: null,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(12, 12, 12, 0),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Masukkan Alamat Usaha',
                              labelText: 'Alamat/Lokasi Usaha *',
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 0.0),
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
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Container(
                              width: 150.w,
                              child: TextFormField(
                                // controller: berita_C.judul_kegiatanCon,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(12, 12, 12, 0),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Masukkan Harga Roda 2',
                                  labelText: 'Harga Roda 2 *',
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 0.0),
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
                            SizedBox(width: 5.w),
                            Container(
                              width: 150.w,
                              child: TextFormField(
                                // controller: berita_C.judul_kegiatanCon,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(12, 12, 12, 0),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Masukkan Harga Roda 4',
                                  labelText: 'Harga Roda 4 *',
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 0.0),
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
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 120.w,
                        child: OutlinedButton.icon(
                            //Handle button press event
                            onPressed: () {
                              //berita_C.CheckInput(aksi: aksi, id_kegiatan: Id);
                            },
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                color: lightBlueColor,
                                width: 1,
                              ),
                              onPrimary: lightBlueColor,
                            ),
                            icon: const Icon(Icons.save_alt),
                            label: const Text("Simpan")),
                      ),
                      SizedBox(
                        width: 120.w,
                        child: OutlinedButton.icon(
                            //Handle button press event
                            onPressed: () {
                              Get.back();
                              //berita_C.hapusisi();
                            },
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                color: lightRedColor,
                                width: 1,
                              ),
                              onPrimary: lightRedColor,
                            ),
                            icon: const Icon(Icons.cached_rounded),
                            label: const Text("Batal")),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
