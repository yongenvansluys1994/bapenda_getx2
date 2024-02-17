// ignore_for_file: avoid_print

import 'package:bapenda_getx2/app/modules/lapor_pajak/models/model_getpelaporanuser.dart';
import 'package:bapenda_getx2/app/modules/lapor_pajak/models/model_objekku.dart';
import 'package:bapenda_getx2/app/modules/myprofil/models/model_ads.dart';
import 'package:dio/dio.dart';
import 'package:bapenda_getx2/app/core/api/api.dart';

class DashboardServices {
  Api api;
  DashboardServices(this.api);

  Future getdata(data) {
    return api.insertData(data).then(
      (value) {
        return value.data;
      },
    ).catchError(
      (e) {
        throw Exception(
          e.runtimeType == DioError ? (e as DioError).error : "Error: $e",
        );
      },
    );
  }

  Future<List<ModelObjekku>?> getPajak(nik) async {
    return api.getData(nik).then(
      (value) {
        return value;
      },
    ).catchError(
      (e) {
        throw Exception(
          e.runtimeType == DioError ? (e as DioError).error : "Error: $e",
        );
      },
    );
  }

  Future<List<ModelGetpelaporanUser>?> getSPT(List list_wajibpajak) async {
    return api.getSPTPembayaran(list_wajibpajak).then(
      (value) {
        return value;
      },
    ).catchError(
      (e) {
        throw Exception(
          e.runtimeType == DioError ? (e as DioError).error : "Error: $e",
        );
      },
    );
  }

  Future<List<ModelAds>?> getAds() async {
    return api.getAdsAll().then(
      (value) {
        return value;
      },
    ).catchError(
      (e) {
        throw Exception(
          e.runtimeType == DioError ? (e as DioError).error : "Error: $e",
        );
      },
    );
  }

  Future<List<ModelAds>?> getPPID() async {
    return api.getPPIDAll().then(
      (value) {
        return value;
      },
    ).catchError(
      (e) {
        throw Exception(
          e.runtimeType == DioError ? (e as DioError).error : "Error: $e",
        );
      },
    );
  }
}
