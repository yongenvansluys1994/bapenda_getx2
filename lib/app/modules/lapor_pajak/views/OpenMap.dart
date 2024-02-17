import 'package:bapenda_getx2/app/modules/lapor_pajak/controllers/lengkapi_data_controller.dart';
import 'package:bapenda_getx2/core/location_service.dart';
import 'package:bapenda_getx2/widgets/custom_appbar.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class OpenMap extends GetView<LengkapiDataController> {
  OpenMap({Key? key}) : super(key: key);

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
                    controller.PickedLocation(pickedData);
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
