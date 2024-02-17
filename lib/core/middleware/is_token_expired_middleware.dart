// ignore_for_file: unnecessary_overrides, no_leading_underscores_for_local_identifiers

import 'package:bapenda_getx2/app/modules/auth/service/auth_cache_service.dart';
import 'package:bapenda_getx2/app/routes/app_pages.dart';
import 'package:bapenda_getx2/core/middleware/auth_middleware.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class IsTokenExpiredMiddleware extends GetMiddleware with AuthCacheService {
  final AuthMiddleware auth = Get.find<AuthMiddleware>();
  bool isExpired = false;
  int i = 0;

  redirect(String? route) {
    var _token = getToken();

    if (_token!.isNotEmpty) {
      i++;
      bool _isExpired = JwtDecoder.isExpired(_token);
      if (_isExpired) {
        isExpired = true;
        auth.loggedInStatus = false;
        Get.snackbar(
          'Notification',
          "Session time out",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        Get.offAllNamed(Routes.LOGIN);
      }
    }
    return null;
  }

  @override
  GetPage? onPageCalled(GetPage? page) {
    return super.onPageCalled(page);
  }

  //This function will be called right before the Bindings are initialized.
  // Here we can change Bindings for this page.
  @override
  List<Bindings>? onBindingsStart(List<Bindings>? bindings) {
    return super.onBindingsStart(bindings);
  }

  //This function will be called right after the Bindings are initialized.
  // Here we can do something after  bindings created and before creating the page widget.
  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) {
    return super.onPageBuildStart(page);
  }

  // Page build and widgets of page will be shown
  @override
  Widget onPageBuilt(Widget page) {
    return super.onPageBuilt(page);
  }

  //This function will be called right after disposing all the related objects
  // (Controllers, views, ...) of the page.
  @override
  void onPageDispose() {
    super.onPageDispose();
  }
}
