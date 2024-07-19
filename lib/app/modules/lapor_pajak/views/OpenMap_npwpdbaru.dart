import 'package:bapenda_getx2/app/modules/tambah_npwpdbaru/controllers/tambah_npwpdbaru_controller.dart';
import 'package:bapenda_getx2/core/location_service.dart';
import 'package:bapenda_getx2/widgets/custom_appbar.dart';
import 'package:bapenda_getx2/widgets/easythrottle.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class OpenMapNpwpdBaru extends GetView<TambahNpwpdbaruController> {
  OpenMapNpwpdBaru({Key? key}) : super(key: key);

  LocationService locationService = LocationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: homeScaffoldKey,
        appBar: CustomAppBar(
          title: "Pilih titik Lokasi Objek",
          leading: true,
          isLogin: true,
        ),
        body: StreamBuilder<UserLocation>(
          stream: locationService.locationStream,
          builder: (_, snapshot) => (snapshot.hasData)
              ? OpenStreetMapSearchAndPick(
                  center: LatLong(
                      snapshot.data!.latitude, snapshot.data!.longitude),
                  buttonColor: Colors.blue,
                  buttonText: 'Tetapkan Lokasi',
                  onPicked: (pickedData) {
                     easyThrottle5(handler: () {
                      controller.PickedLocation(pickedData);
                    },);
                  })
              : Dialog(
                  // The background color
                  backgroundColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        // The loading indicator
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 15,
                        ),
                        // Some text
                        Text('Loading...')
                      ],
                    ),
                  ),
                ),
        ));
  }
}

const kGoogleApiKey = 'AIzaSyB4f3mGrAfD82yB4zn0eP0tbBpMNCSHr9c';
final homeScaffoldKey = GlobalKey<ScaffoldState>();
