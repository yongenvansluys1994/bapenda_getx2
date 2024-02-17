import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'texts.dart';

class Buttons {
  static Widget defaultButton2({
    required VoidCallback handler,
    required Widget widget,
    required bool? borderSide,
    bool filled = false,
    Color? fillColor,
    double borderRadius = 5,
    Color? borderSideColor,
    double borderSideWidth = 0,
  }) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        backgroundColor:
            filled ? MaterialStateProperty.all<Color?>(fillColor) : null,
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: borderSide!
                ? BorderSide(
                    color: borderSideColor!,
                    width: borderSideWidth,
                  )
                : BorderSide(
                    color: Colors.transparent,
                    width: borderSideWidth,
                  ),
          ),
        ),
      ),
      onPressed: handler,
      child: widget,
    );
  }

  static Widget defaultButton({
    required VoidCallback handler,
    required Widget widget,
    required bool? borderSide,
    Color? fillColor,
    double borderRadius = 5,
    Color? borderSideColor,
    double borderSideWidth = 0,
  }) {
    return Container(
      width: double.infinity,
      height: 35.sp,
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ElevatedButton(
        onPressed: handler,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: borderSide!
                ? BorderSide(
                    color: borderSideColor!,
                    width: borderSideWidth,
                  )
                : BorderSide(
                    color: Colors.transparent,
                    width: borderSideWidth,
                  ),
          ),
        ),
        child: widget,
      ),
    );
  }

  static Widget gradientButton({
    required VoidCallback handler,
    required Widget widget,
    bool borderSide = false,
    required List<Color> gradient,
    double borderRadius = 5,
    Color? borderSideColor,
    double borderSideWidth = 0,
  }) {
    return Container(
      width: double.infinity,
      height: 35.sp,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: gradient),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ElevatedButton(
        onPressed: handler,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: borderSide!
                ? BorderSide(
                    color: borderSideColor!,
                    width: borderSideWidth,
                  )
                : BorderSide(
                    color: Colors.transparent,
                    width: borderSideWidth,
                  ),
          ),
        ),
        child: widget,
      ),
    );
  }

  static Widget textButton({
    required VoidCallback handler,
    required Widget widget,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: TextButton(
        onPressed: handler,
        child: widget,
      ),
    );
  }

  static Widget buttonCard({
    required String title,
    String? subtitle,
    IconData? iconData,
    required VoidCallback handler,
    bool isTrailing = false,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: handler,
          child: Container(
            margin: EdgeInsets.all(10.sp),
            padding: EdgeInsets.all(10.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    iconData != null
                        ? Icon(
                            iconData,
                            color: Get.theme.primaryColor,
                          )
                        : SizedBox(),
                    SizedBox(
                      width: 20.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Texts.body1(title),
                        SizedBox(
                          height: 5.h,
                        ),
                        subtitle != null
                            ? Texts.body2(subtitle)
                            : const SizedBox(),
                      ],
                    ),
                  ],
                ),
                isTrailing
                    ? const Icon(
                        Icons.chevron_right,
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
        Divider(
          height: 0.h,
          thickness: .5,
        ),
      ],
    );
  }

  static Widget defaultButtonSm({
    required VoidCallback handler,
    required String title,
    Color? fillColor,
    bool? isDisabled,
  }) {
    return SizedBox(
        //width: height.h,// <-- Your width
        height: 20.h, // <-- Your height
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: isDisabled == true ? Colors.grey : fillColor,
            ),
            onPressed: handler,
            child: Text(
              title,
              style: TextStyle(fontSize: 9.sp),
            )));
  }

  static Widget defaultButtonMed({
    required VoidCallback handler,
    required String title,
    Color? fillColor,
    bool? isDisabled,
  }) {
    return SizedBox(
        //width: height.h,// <-- Your width
        height: 28.h, // <-- Your height
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: isDisabled == true ? Colors.grey : fillColor,
            ),
            onPressed: handler,
            child: Text(
              title,
              style: TextStyle(fontSize: 11.sp),
            )));
  }

  static Widget elevatedButton({
    required VoidCallback handler,
    required String title,
    required Color? fillColor,
    bool? isDisabled,
    int height = 50,
  }) {
    return SizedBox(
        //width: height.h,// <-- Your width
        height: height.h, // <-- Your height
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: isDisabled == true ? Colors.grey : fillColor,
            ),
            onPressed: isDisabled == true ? null : handler,
            child: Text(
              title,
              style: TextStyle(fontSize: 9.sp),
            )));
  }

  static Widget buttonCard2({
    required String title,
    String? subtitle,
    required IconData iconData,
    required VoidCallback handler,
    bool isTrailing = false,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: handler,
          child: Container(
              margin: EdgeInsets.only(left: 10.w, right: 10.w),
              padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10.sp),
                    decoration: BoxDecoration(
                      color: Get.theme.primaryColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Icon(
                      iconData,
                      color: Get.theme.primaryColor,
                      size: 35.sp,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Texts.body1(title),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  subtitle != null
                                      ? Texts.body2(
                                          subtitle,
                                          color: Colors.grey,
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                              isTrailing
                                  ? const Icon(
                                      Icons.chevron_right,
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Divider(
                          height: 0.h,
                          thickness: .3.h,
                        ),
                      ],
                    ),
                  )
                ],
              )

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Row(
              //       children: [
              //         Icon(
              //           iconData,
              //           color: Get.theme.primaryColor,
              //         ),
              //         SizedBox(
              //           width: 20.w,
              //         ),
              //         Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Texts.body1(title),
              //             SizedBox(
              //               height: 5.h,
              //             ),
              //             subtitle != null
              //                 ? Texts.body2(
              //                     subtitle,
              //                     color: Colors.grey,
              //                   )
              //                 : const SizedBox(),
              //             Divider(
              //               height: 0.h,
              //               thickness: 1.h,
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //     const Icon(
              //       Icons.chevron_right,
              //     )
              //   ],
              // ),
              ),
        ),
      ],
    );
  }
}
