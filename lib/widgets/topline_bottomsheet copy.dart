import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget topline_bottomsheet() {
  return Align(
    alignment: Alignment.center,
    child: Container(
      width: 12.w,
      height: 4,
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    ),
  );
}
