import 'dart:convert';

import 'package:bapenda_getx2/app/modules/chat/models/model_chat.dart';
import 'package:bapenda_getx2/app/modules/chat/models/model_checkroom.dart';
import 'package:bapenda_getx2/app/modules/ekitiran_form/models/pbbkitiran_model.dart';
import 'package:bapenda_getx2/app/modules/kartunpwpd/models/model_kartudata.dart';
import 'package:bapenda_getx2/app/modules/lapor_pajak/models/model_getpelaporanuser.dart';
import 'package:bapenda_getx2/app/modules/lapor_pajak/models/model_objekku.dart';
import 'package:bapenda_getx2/app/modules/myprofil/models/model_ads.dart';
import 'package:bapenda_getx2/app/modules/notifikasi/models/model_notifikasi.dart';
import 'package:bapenda_getx2/app/modules/pbb/models/model_pbb.dart';
import 'package:bapenda_getx2/widgets/getdialog.dart';
import 'package:bapenda_getx2/widgets/logger.dart';
import 'package:dio/dio.dart';

//const baseUrl = 'https://yongen-bisa.com/bapenda_app/api';
const baseUrl = 'https://yongen-bisa.com/bapenda_app/api_ver2';
const URL_APP = "https://yongen-bisa.com/bapenda_app/api_ver2";
const URL_SIMPATDA = "http://simpatda.bontangkita.id/simpatda";
const URL_APPSIMPATDA = "http://simpatda.bontangkita.id/api_ver2";
const URL_SISMIOP = "https://pajak.bontangkita.id/sismiop/api";
const String ApiFCM =
    "AAAAB69wS5U:APA91bGHHGdo_FzlMJlzO0rc4SUPIMt10OZLqzT60DwVdIU_SSmYkDVu5LRofJR3u9_AS8_ptJ-S5dHIB-7BYWoOTrHUY-pe04UKfLDuAH1ezeY7ohWZalRdShAfJOchSVR9wDuusnnj";

final Dio dio3 = Dio(
  BaseOptions(
    baseUrl: URL_APPSIMPATDA,
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
    headers: {'Content-Type': 'application/json'},
  ),
);

final Dio dioChat = Dio(
  BaseOptions(
    baseUrl: URL_APPSIMPATDA,
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
    headers: {'Content-Type': 'application/json'},
  ),
);

final Dio dioBaseUrl = Dio(
  BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
    headers: {'Content-Type': 'application/json'},
  ),
);
final Dio dioSismiop = Dio(
  BaseOptions(
    baseUrl: URL_SISMIOP,
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
    headers: {'Content-Type': 'application/json'},
  ),
);

Future<Map<String, dynamic>?> getPbb(String nopthn) async {
  try {
    final response = await dioSismiop.get(
      "/informasi/piutang/$nopthn",
      options: Options(
        headers: {
          'Authorization':
              'Basic ${base64Encode(utf8.encode('API_BPD_ETAM:API_BPD_ETAM'))}',
        },
      ),
    );

    if (response.statusCode == 200) {
      var isError = response.data["is_error"];
      var message = response.data["message"];
      logInfo(message);

      if (isError == true) {
        return {"isError": isError, "message": message};
      } else {
        var informasiData = response.data["data"]["informasi"];
        var informasi = ModelPbbInformasi.fromJson(informasiData);

        List spptData = response.data["data"]["sppt"];
        List<ModelPbbSppt> spptList =
            spptData.map((e) => ModelPbbSppt.fromJson(e)).toList();

        return {
          "isError": isError,
          "informasi": informasi,
          "sppt": spptList,
          "message": message,
        };
      }
    } else {
      return null;
    }
  } on DioError catch (ex) {
    throw ex;
  }
}

Future<Map<String, dynamic>?> get_PBB(NOPTHN) async {
  var response =
      await dioSismiop.get("/informasi/piutang/64.74.010.001.006.1565.0");

  if (response.statusCode == 200) {
    // Extract the 'informasi' part as a single object
    var isError = response.data["is_error"];
    var message = response.data["message"];

    if (response.data["is_error"] == true) {
      // Return both in a map
      return {"isError": isError, "message": message};
    } else {
      var informasiData = response.data["data"]["informasi"];
      var informasi = ModelPbbInformasi.fromJson(informasiData);

      // Extract the 'sppt' part as a list of objects
      List spptData = response.data["data"]["sppt"];
      List<ModelPbbSpptKitiran> spptList =
          spptData.map((e) => ModelPbbSpptKitiran.fromJson(e)).toList();

      // Return both in a map
      return {
        "isError": isError,
        "informasi": informasi,
        "sppt": spptList,
        "message": message
      };
    }
  } else {
    return null;
  }
}

Future<Map<String, dynamic>?> get_PBBNew(String NOP) async {
  try {
    var response = await dioSismiop.get(
      "/informasi/wajib_pajak/$NOP",
      options: Options(
        headers: {
          'Authorization':
              'Basic ${base64Encode(utf8.encode('API_BPD_ETAM:API_BPD_ETAM'))}',
        },
      ),
    );

    if (response.statusCode == 200) {
      var isError = response.data["is_error"];
      var message = response.data["message"];

      if (isError == true) {
        return {"isError": isError, "message": message};
      } else {
        var informasiData = response.data["data"]["informasi"];
        print(jsonEncode(informasiData));

        if (informasiData is Map<String, dynamic>) {
          var informasi = ModelPbbInformasi.fromJson(
              informasiData); // Correctly parse the Map to the Model
          return {
            "isError": isError,
            "informasi": informasi,
            "message": message
          };
        } else {
          print(
              "Unexpected data type for 'informasi': ${informasiData.runtimeType}");
        }
      }
    }
    return null;
  } catch (e) {
    print("Exception: $e");
    return null;
  }
}

Future<List<ModelCheckRoom>?> checkRoom(id_userwp) async {
  var response = await dioChat.get("/chat/check_room.php?id_userwp=$id_userwp");
  if (response.statusCode == 200) {
    List data = (json.decode(response.data) as Map<String, dynamic>)["data"];
    return data.map((e) => ModelCheckRoom.fromJson(e)).toList();
  } else {
    return null;
  }
}

Future<List<ModelChat>?> getChat(roomID) async {
  var response = await dioChat.get("/chat/isi_chat.php?room_id=$roomID");
  if (response.statusCode == 200) {
    List data = (json.decode(response.data) as Map<String, dynamic>)["data"];

    return data.map((e) => ModelChat.fromJson(e)).toList();
  } else {
    return null;
  }
}

Future<Response> readChat(int id_userwp, roomID) {
  return dioChat.put(
    "/chat/read_chat.php?id_userwp=$id_userwp&room_id=$roomID",
  );
}

Future<Response> sendChat(data) {
  return dioChat.post(
    "/chat/send_chat.php",
    data: data,
  );
}

Future<List<ModelListNotifikasi>?> getNotifikasi(nik) async {
  var response = await dio3.get("/notifikasi/cek_notifikasi.php?nik=$nik");
  if (response.statusCode == 200) {
    List data = (json.decode(response.data) as Map<String, dynamic>)["data"];

    return data.map((e) => ModelListNotifikasi.fromJson(e)).toList();
  } else {
    return null;
  }
}

Future<Response> updateDataNotifikasi(List<String> idList) {
  return dio3.put(
    "/notifikasi/update_notifikasi.php",
    data: {
      'ids': idList,
    },
  );
}

Future<Response> updateDataNotifikasi2(nik) {
  return dio3.put(
    "/notifikasi/update_notifikasi2.php?nik=$nik",
  );
}

class Api {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(seconds: 25),
      receiveTimeout: Duration(seconds: 25),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  final Dio dio2 = Dio(
    BaseOptions(
      baseUrl: "http://simpatda.bontangkita.id/simpatda/api_mobile2",
      connectTimeout: Duration(seconds: 25),
      receiveTimeout: Duration(seconds: 25),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  // Future<Response> getDataByDeliveryNumber(number) {
  //   return dio
  //       .get("/v1/api/rest/material-movement/$number?isReadableField=true");
  // }

  Future<Response> insertData(data) {
    return dio.post(
      "/login/login.php",
      data: data, //kalo post butuh data
    );
  }

  Future<Response> insertTokenFCM(data) {
    return dio.post(
      "/login/token_fcm.php",
      data: data,
    );
  }

  Future<Response> getUrlSimpatda() {
    return dio3.post(
      "/cek_utilitas/checkInternet.php",
      options: Options(
        receiveTimeout: Duration(seconds: 5), // Timeout maksimal 5 detik
        sendTimeout: Duration(seconds: 5),
        validateStatus: (status) {
          return status! < 500; // Anggap sukses jika status di bawah 500
        },
      ),
    );
  }

  Future<Response> deleteData(int number) {
    return dio.delete("/v1/api/rest/material-movement/$number");
  }

  Future<List<ModelObjekku>?> getData(nik) async {
    var response = await dio.get("/objekku/$nik");
    if (response.statusCode == 200) {
      List data = (json.decode(response.data) as Map<String, dynamic>)["data"];

      return data.map((e) => ModelObjekku.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  Future<List<ModelKartuData>?> getNPWPD(nik) async {
    var response = await dio.get("/kartudata/$nik");
    if (response.statusCode == 200) {
      List data = (json.decode(response.data) as Map<String, dynamic>)["data"];

      return data.map((e) => ModelKartuData.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  Future<List<ModelAds>?> getAds(nik) async {
    var response = await dio.get("/ads/flat.php?kategori=user&nik=$nik");
    if (response.statusCode == 200) {
      List data = (json.decode(response.data) as Map<String, dynamic>)["data"];

      return data.map((e) => ModelAds.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  Future<List<ModelAds>?> getPPID(nik) async {
    var response = await dio.get("/ppid/flat.php?kategori=user&nik=$nik");
    if (response.statusCode == 200) {
      List data = (json.decode(response.data) as Map<String, dynamic>)["data"];

      return data.map((e) => ModelAds.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  Future<List<ModelAds>?> getAdsAll() async {
    var response = await dio.get("/ads/flat.php?kategori=home");

    if (response.statusCode == 200) {
      List data = (json.decode(response.data) as Map<String, dynamic>)["data"];
      //print(jsonEncode(data.toList()));

      return data.map((e) => ModelAds.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  Future<List<ModelAds>?> getPPIDAll() async {
    var response = await dio.get("/ppid/flat.php?kategori=home");

    if (response.statusCode == 200) {
      List data = (json.decode(response.data) as Map<String, dynamic>)["data"];
      //print(jsonEncode(data.toList()));

      return data.map((e) => ModelAds.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  Future<List<ModelGetpelaporanUser>?> getSPTPembayaran(
      List list_wajibpajak) async {
    var response = await dio2.post(
      "/GetPelaporanPembayaran/edee9b7c-b723-4990-a674-dfd6da7efdd1",
      data: {
        'list_wajibpajak': list_wajibpajak,
        // Add other data if needed
      },
    );
    if (response.statusCode == 200) {
      List data = json.decode(response.data);

      return data.map((e) => ModelGetpelaporanUser.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  Future<List<ModelGetpelaporanUser>?> getPelaporanHistory(
      {required String id_wajib_pajak,
      required int tahun,
      required String jenispajak}) async {
    var response = await dio.get(
        "/get_pelaporan_merge2/index.php?id_wajib_pajak=${id_wajib_pajak}&tahun=${tahun}&jenispajak=${jenispajak}");
    if (response.statusCode == 200) {
      //print(response.data); //untuk check response yang diberikan oleh url
      List data = json.decode(response.data);

      return data.map((e) => ModelGetpelaporanUser.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  Future<List<MarkerData>> fetchMarkersData() async {
    var response = await dio.get("/get_markers/index.php");

    if (response.statusCode == 200) {
      final data = json.decode(response.data);
      return (data as List)
          .map((item) => MarkerData(
                latitude: item['lat'],
                longitude: item['lng'],
              ))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Future<List<ModelObjekku>?> getObjekku() async {
  //   var response = await http.get(Uri.parse("${URL_APP}/api/objekku/123"));
  //   if (response.statusCode == 200) {
  //     List data = (json.decode(response.body) as Map<String, dynamic>)["data"];
  //     return data.map((e) => ModelObjekku.fromJson(e)).toList();
  //   } else {
  //     return null;
  //   }
  // }

  // static Future<List<ModeldataBerita>?> databeritaall() async {
  //   final url = '$baseUrl';
  //   final res = await http.get(Uri.parse(url)).timeout(timeLimit);

  //   print(url);

  //   if (res.statusCode == 200) {
  //     final json = await compute(jsonDecode, res.body);

  //     if (json is Map && json.containsKey('data')) {
  //       final data = json['data']['data'];

  //       if (data is List) {
  //         return data
  //             .map<ModeldataBerita>((u) => ModeldataBerita.fromJson(u))
  //             .toList();
  //       }
  //     }
  //   }

  //   return null;
  // }

  // Future<Response> updateData(int number, DeliveryNumberData data) {
  //   return dio.put(
  //     "/v1/api/rest/material-movement/$number",
  //     data: data,
  //   );
  // }
}

class MarkerData {
  final double latitude;
  final double longitude;

  MarkerData({required this.latitude, required this.longitude});
}
