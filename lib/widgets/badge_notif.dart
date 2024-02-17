import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class notif extends StatelessWidget {
  final bool showbadge;
  final int number;
  const notif({Key? key, required this.showbadge, required this.number})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.98,
      child: Transform.translate(
          offset: Offset(30.r, -93.r),
          child: badges.Badge(
            showBadge: showbadge,
            badgeStyle: badges.BadgeStyle(badgeColor: Colors.red),
            badgeContent: Container(
              width: 30.w,
              height: 30.h,
              alignment: Alignment.center,
              child: Text(
                '$number',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )),
    );
  }
}
