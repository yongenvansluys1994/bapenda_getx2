import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:bapenda_getx2/widgets/utils/helper/suffix_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import './utils/controllers/date_and_time_picker_controller.dart';
import './utils/controllers/date_picker_controller.dart';
import './utils/controllers/date_range_picker_controller.dart';
import './utils/controllers/textfield_controller.dart';
import './utils/controllers/time_picker_controller.dart';
import './texts.dart';

class TextFields {
  static Widget defaultTextField({
    Key? key,
    required TextInputAction textInputAction,
    required TextInputType textInputType,
    required bool isLoading,
    required TextFieldController textFieldController,
    String? initialValue,
    IconData? prefixIcon,
    bool hasInitialValue = false,
    bool readOnly = false,
    bool isRequired = false,
    String? title,
    Color borderColor = darkColor,
    bool isSuffixIcon = false,
    SuffixType suffixType = SuffixType.icon,
    IconData? suffixIcon,
    String? suffixText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null && title.isNotEmpty
            ? isRequired
                ? Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Row(
                      children: [
                        Texts.body2(title),
                        Texts.body2("*", color: Colors.red),
                      ],
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Texts.body2(title),
                  )
            : const SizedBox.shrink(),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            child: TextFormField(
              readOnly: readOnly,
              cursorColor: Get.theme.primaryColor,
              inputFormatters: textFieldController.inputFormatter ?? [],
              initialValue: textFieldController.text,
              enabled: !isLoading,
              obscureText: textFieldController.obscureText &&
                  !textFieldController.visible,
              textInputAction: textInputAction,
              keyboardType: textInputType,
              onChanged: textFieldController.onChange,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide(
                      width: 1.w,
                      color: readOnly ? readOnlyBorderColor : borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide(
                    width: 1.w,
                    color: readOnly
                        ? readOnlyBorderColor
                        : textFieldController.isValid
                            ? readOnlyBorderColor
                            : errorColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide(
                    width: 1.w,
                    color: readOnly
                        ? readOnlyBorderColor
                        : textFieldController.isValid
                            ? readOnlyBorderColor
                            : errorColor,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide(width: 1.w, color: errorColor),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide(width: 3.w, color: darkColor),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.h),
                hintText: textFieldController.title,
                prefixIcon: prefixIcon == null
                    ? null
                    : Icon(
                        prefixIcon,
                        color: Get.theme.primaryColor,
                      ),
                filled: true,
                fillColor: readOnly ? readOnlyColor : lightColor,
                suffixIcon: textFieldController.obscureText ||
                        textFieldController.visible
                    ? IconButton(
                        icon: Icon(
                          textFieldController.visible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          textFieldController.toogleVisible();
                        },
                        splashRadius: 24.r,
                      )
                    : isSuffixIcon
                        ? (suffixType == SuffixType.icon
                            ? Icon(suffixIcon)
                            : Padding(
                                padding: EdgeInsets.only(top: 16.h),
                                child: Texts.body2(suffixText!),
                              ))
                        : null,
              ),
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: !textFieldController.isValid
              ? Padding(
                  padding: EdgeInsets.all(1.0.sp),
                  child: Texts.caption(
                    textFieldController.errorMessage,
                    color: Get.theme.colorScheme.error,
                    textOverflow: TextOverflow.visible,
                  ),
                )
              : const SizedBox(),
        ),
      ],
    );
  }

  static Widget dateTextField({
    Key? key,
    required TextInputAction textInputAction,
    required TextInputType textInputType,
    required bool isLoading,
    required DatePickerController datePickerController,
    String? initialValue,
    IconData? iconData,
    String? title,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null && title.isNotEmpty
            ? isRequired
                ? Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Row(
                      children: [
                        Texts.body2(title),
                        Texts.body2("*", color: Colors.red),
                      ],
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Texts.body2(title),
                  )
            : const SizedBox.shrink(),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: Container(
            margin: EdgeInsets.only(
              top: 10.h,
            ),
            padding: EdgeInsets.only(left: 10.w, right: 10.w),
            decoration: BoxDecoration(
              color: Get.theme.colorScheme.background,
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              border: Border.all(
                width: 1.w,
                color: !datePickerController.isValid
                    ? Colors.red
                    : Get.theme.shadowColor,
              ),
            ),
            child: TextFormField(
              controller: datePickerController.textEditingController,
              readOnly: true,
              textInputAction: textInputAction,
              keyboardType: textInputType,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 15.h),
                icon: iconData == null
                    ? null
                    : Icon(
                        iconData,
                      ),
                filled: true,
                fillColor: Get.theme.colorScheme.background,
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.date_range,
                    color: darkColor,
                  ),
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: Get.context!,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2015, 8),
                      lastDate: DateTime(2101),
                      builder: (context, child) {
                        return Theme(
                          data: Get.theme.brightness == Brightness.light
                              ? Get.theme.copyWith(
                                  // Light Theme
                                  colorScheme: ColorScheme.light(
                                    primary:
                                        Get.theme.primaryColor, // <-- SEE HERE
                                    // onPrimary: Get.theme., // <-- SEE HERE
                                    // onSurface: Colors.blueAccent, // <-- SEE HERE
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Get.theme
                                          .primaryColor, // button text color
                                    ),
                                  ),
                                )
                              : Get.theme.copyWith(
                                  // Dark Theme
                                  colorScheme: ColorScheme.light(
                                    primary:
                                        Get.theme.primaryColor, // <-- SEE HERE
                                    // onPrimary: Colors.amber, // <-- SEE HERE
                                    onSurface: Colors.white, // <-- SEE HERE
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Get.theme
                                          .primaryColor, // button text color
                                    ),
                                  ),
                                ),
                          child: child!,
                        );
                      },
                    );
                    if (picked != null) {
                      datePickerController.changeDate(picked);
                    }
                  },
                  splashRadius: 24.r,
                ),
              ),
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: !datePickerController.isValid
              ? Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: Texts.overline(
                    datePickerController.errorMessage,
                    color: Get.theme.colorScheme.error,
                    textOverflow: TextOverflow.visible,
                  ),
                )
              : const SizedBox(),
        ),
      ],
    );
  }

  static Widget timeTextField({
    Key? key,
    required TextInputAction textInputAction,
    required TextInputType textInputType,
    required bool isLoading,
    required TimePickerController timePickerController,
    String? initialValue,
    IconData? iconData,
    String? title,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null && title.isNotEmpty
            ? isRequired
                ? Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Row(
                      children: [
                        Texts.body2(title),
                        Texts.body2("*", color: Colors.red),
                      ],
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Texts.body2(title),
                  )
            : const SizedBox.shrink(),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: Container(
            margin: EdgeInsets.only(
              top: 10.h,
            ),
            padding: EdgeInsets.only(left: 10.w, right: 10.w),
            decoration: BoxDecoration(
              color: Get.theme.colorScheme.background,
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              border: Border.all(
                width: 1.w,
                color: !timePickerController.isValid
                    ? Colors.red
                    : Get.theme.shadowColor,
              ),
            ),
            child: TextFormField(
              controller: timePickerController.textEditingController,
              readOnly: true,
              textInputAction: textInputAction,
              keyboardType: textInputType,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                labelText: timePickerController.title,
                // icon: iconData == null
                //     ? null
                //     : Icon(
                //         iconData,
                //       ),
                filled: true,
                fillColor: Get.theme.colorScheme.background,
                suffixIcon: IconButton(
                  icon: Icon(
                    iconData,
                  ),
                  onPressed: () async {
                    final TimeOfDay? timePick = await showTimePicker(
                      context: Get.context!,
                      initialTime: TimeOfDay.now(),
                      builder: (context, child) => MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(alwaysUse24HourFormat: true),
                        child: Theme(
                          data: ThemeData.light().copyWith(
                            colorScheme: ColorScheme.light(
                                primary: Get.theme.primaryColor),
                          ),
                          child: child ?? Container(),
                        ),
                      ),
                    );
                    if (timePick != null) {
                      timePickerController.changeDate(timePick);
                    }
                  },
                  splashRadius: 24.r,
                ),
              ),
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: !timePickerController.isValid
              ? Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: Texts.overline(
                    timePickerController.errorMessage,
                    color: Get.theme.colorScheme.error,
                    textOverflow: TextOverflow.visible,
                  ),
                )
              : const SizedBox(),
        ),
      ],
    );
  }

  static Widget dateAndTimeTextField({
    Key? key,
    required TextInputAction textInputAction,
    required TextInputType textInputType,
    required bool isLoading,
    required DateAndTimePickerController dateAndTimePickerController,
    String? initialValue,
    IconData? suffixIcon,
    IconData? icon,
    DateTime? firstDate,
    DateTime? lastDate,
    bool isDate = true,
    bool isTime = true,
    String? title,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null && title.isNotEmpty
            ? isRequired
                ? Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Row(
                      children: [
                        Texts.body2(title),
                        Texts.body2("*", color: Colors.red),
                      ],
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Texts.body2(title),
                  )
            : const SizedBox.shrink(),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: Container(
            margin: EdgeInsets.only(
              top: 10.h,
            ),
            padding: EdgeInsets.only(left: 10.w, right: 10.w),
            decoration: BoxDecoration(
              color: Get.theme.colorScheme.background,
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              border: Border.all(
                width: 1.w,
                color: !dateAndTimePickerController.isValid
                    ? Colors.red
                    : Get.theme.shadowColor,
              ),
            ),
            child: TextFormField(
              controller: dateAndTimePickerController.textEditingController,
              readOnly: true,
              textInputAction: textInputAction,
              keyboardType: textInputType,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                labelText: dateAndTimePickerController.title,
                icon: icon == null
                    ? null
                    : Icon(
                        icon,
                      ),
                filled: true,
                fillColor: Get.theme.colorScheme.background,
                suffixIcon: suffixIcon == null
                    ? null
                    : IconButton(
                        icon: Icon(
                          suffixIcon,
                        ),
                        onPressed: () async {
                          DateTime? datePick;
                          TimeOfDay? timePick;

                          if (isDate) {
                            datePick = await showDatePicker(
                              context: Get.context!,
                              initialDate: DateTime.now(),
                              firstDate: firstDate ?? DateTime(2015, 8),
                              lastDate: lastDate ?? DateTime(2101),
                              builder: (context, child) {
                                return Theme(
                                  data: Get.theme.brightness == Brightness.light
                                      ? Get.theme.copyWith(
                                          // Light Theme
                                          colorScheme: ColorScheme.light(
                                            primary: Get.theme
                                                .primaryColor, // <-- SEE HERE
                                            // onPrimary: Get.theme., // <-- SEE HERE
                                            // onSurface: Colors.blueAccent, // <-- SEE HERE
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              foregroundColor: Get.theme
                                                  .primaryColor, // button text color
                                            ),
                                          ),
                                        )
                                      : Get.theme.copyWith(
                                          // Dark Theme
                                          colorScheme: ColorScheme.light(
                                            primary: Get.theme
                                                .primaryColor, // <-- SEE HERE
                                            // onPrimary: Colors.amber, // <-- SEE HERE
                                            onSurface:
                                                Colors.white, // <-- SEE HERE
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              foregroundColor: Get.theme
                                                  .primaryColor, // button text color
                                            ),
                                          ),
                                        ),
                                  child: child!,
                                );
                              },
                            );
                          }
                          if (isTime) {
                            timePick = await showTimePicker(
                              context: Get.context!,
                              initialTime: TimeOfDay.now(),
                              builder: (context, child) => MediaQuery(
                                data: MediaQuery.of(context)
                                    .copyWith(alwaysUse24HourFormat: true),
                                child: Theme(
                                  data: ThemeData.light().copyWith(
                                    colorScheme: ColorScheme.light(
                                        primary: Get.theme.primaryColor),
                                  ),
                                  child: child ?? Container(),
                                ),
                              ),
                            );
                          }

                          if (datePick != null || timePick != null) {
                            dateAndTimePickerController.changeDate(
                              datePick,
                              timePick,
                            );
                          } else {
                            return;
                          }
                        },
                        splashRadius: 24.r,
                      ),
              ),
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: !dateAndTimePickerController.isValid
              ? Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: Texts.overline(
                    dateAndTimePickerController.errorMessage,
                    color: Get.theme.colorScheme.error,
                    textOverflow: TextOverflow.visible,
                  ),
                )
              : const SizedBox(),
        ),
      ],
    );
  }

  static Widget dateRangeTextField({
    Key? key,
    required TextInputAction textInputAction,
    required TextInputType textInputType,
    required bool isLoading,
    required DateRangePickerController dateRangePickerController,
    String? initialValue,
    IconData? iconData,
    bool readOnly = false,
    String? title,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null && title.isNotEmpty
            ? isRequired
                ? Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Row(
                      children: [
                        Texts.body2(title),
                        Texts.body2("*", color: Colors.red),
                      ],
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Texts.body2(title),
                  )
            : const SizedBox.shrink(),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: Container(
            margin: EdgeInsets.only(
              top: 10.h,
            ),
            // decoration: BoxDecoration(
            //   color: Get.theme.colorScheme.background,
            //   borderRadius: BorderRadius.all(Radius.circular(10.r)),
            //   border: Border.all(
            //     width: 1.w,
            //     color: !datePickerController.isValid
            //         ? Colors.red
            //         : Get.theme.shadowColor,
            //   ),
            // ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextFormField(
                    controller:
                        dateRangePickerController.startEditingController,
                    readOnly: true,
                    textInputAction: textInputAction,
                    keyboardType: textInputType,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(color: Get.theme.shadowColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: readOnly
                              ? Get.theme.shadowColor
                              : dateRangePickerController.isValid
                                  ? Get.theme.primaryColor
                                  : Get.theme.colorScheme.error,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: dateRangePickerController.isValid
                              ? Get.theme.shadowColor
                              : Get.theme.colorScheme.error,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide:
                            BorderSide(color: Get.theme.colorScheme.error),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(color: Get.theme.shadowColor),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 10.w),
                      hintText: 'Start',
                      filled: true,
                      fillColor: Get.theme.colorScheme.background,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: TextFormField(
                    controller: dateRangePickerController.endEditingController,
                    readOnly: true,
                    textInputAction: textInputAction,
                    keyboardType: textInputType,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(color: Get.theme.shadowColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: readOnly
                              ? Get.theme.shadowColor
                              : dateRangePickerController.isValid
                                  ? Get.theme.primaryColor
                                  : Get.theme.colorScheme.error,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: dateRangePickerController.isValid
                              ? Get.theme.shadowColor
                              : Get.theme.colorScheme.error,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide:
                            BorderSide(color: Get.theme.colorScheme.error),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(color: Get.theme.shadowColor),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 10.w),
                      hintText: 'End',
                      filled: true,
                      fillColor: Get.theme.colorScheme.background,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final DateTimeRange? dateTimeRange =
                        await showDateRangePicker(
                      context: Get.context!,
                      firstDate: DateTime(2015, 8),
                      lastDate: DateTime(2102),
                    );

                    if (dateTimeRange != null) {
                      dateRangePickerController.changeDate(
                        DateTime.now(),
                        dateTimeRange: dateTimeRange,
                      );
                    }
                  },
                  icon: const Icon(Icons.date_range),
                  color: Get.theme.primaryColor,
                  splashRadius: 24.r,
                ),
              ],
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: !dateRangePickerController.isValid
              ? Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: Texts.overline(
                    dateRangePickerController.errorMessage,
                    color: Get.theme.colorScheme.error,
                    textOverflow: TextOverflow.visible,
                  ),
                )
              : const SizedBox(),
        ),
      ],
    );
  }

  static Widget multilineTextField({
    Key? key,
    required TextInputAction textInputAction,
    required TextInputType textInputType,
    required bool isLoading,
    required TextFieldController textFieldController,
    IconData? iconData,
    String? initialValue,
    int minLines = 3,
    int maxLines = 5,
    String? title,
    bool isRequired = false,
    bool readOnly = false,
  }) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title != null && title.isNotEmpty
              ? isRequired
                  ? Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Row(
                        children: [
                          Texts.body2(title),
                          Texts.body2("*", color: Colors.red),
                        ],
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Texts.body2(title),
                    )
              : const SizedBox.shrink(),
          Container(
            margin: EdgeInsets.only(
              top: 10.h,
            ),
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            decoration: BoxDecoration(
              color: readOnly ? readOnlyColor : lightColor,
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              border: Border.all(
                width: 1,
                color: !textFieldController.isValid
                    ? Get.theme.colorScheme.error
                    : readOnly
                        ? readOnlyBorderColor
                        : shadowColor3,
              ),
            ),
            child: TextFormField(
              readOnly: readOnly,
              initialValue: textFieldController.text,
              enabled: !isLoading,
              obscureText: textFieldController.obscureText &&
                  !textFieldController.visible,
              textInputAction: textInputAction,
              keyboardType: textInputType,
              onChanged: textFieldController.onChange,
              minLines: minLines,
              maxLines: maxLines,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                icon: iconData == null
                    ? null
                    : Icon(
                        iconData,
                      ),
                filled: true,
                fillColor: readOnly ? readOnlyColor : lightColor,
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            child: !textFieldController.isValid
                ? Padding(
                    padding: EdgeInsets.all(8.0.sp),
                    child: Texts.overline(
                      textFieldController.errorMessage,
                      color: Get.theme.colorScheme.error,
                      textOverflow: TextOverflow.visible,
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }

  static Widget defaultTextField2(
      {Key? key,
      required TextInputAction textInputAction,
      required TextInputType textInputType,
      required bool isLoading,
      required controller,
      String? hintText,
      TextCapitalization? textCapitalization,
      List<TextInputFormatter>? inputFormatter,
      String? initialValue,
      IconData? prefixIcon,
      bool hasInitialValue = false,
      bool readOnly = false,
      bool isRequired = false,
      bool error = false,
      String? errorMessage,
      String? title,
      Color borderColor = darkColor,
      bool isSuffixIcon = false,
      SuffixType suffixType = SuffixType.icon,
      IconData? suffixIcon,
      String? suffixText,
      required bool validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null && title.isNotEmpty
            ? isRequired
                ? Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: Row(
                      children: [
                        Texts.body2(title),
                        Texts.body2("*", color: Colors.red),
                      ],
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: Texts.body2(title),
                  )
            : const SizedBox.shrink(),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: TextFormField(
              controller: controller,
              readOnly: readOnly,
              cursorColor: Get.theme.primaryColor,
              inputFormatters: inputFormatter ?? [],
              enabled: !isLoading,
              textInputAction: textInputAction,
              textCapitalization: textCapitalization ?? TextCapitalization.none,
              keyboardType: textInputType,
              validator: validator == true
                  ? (value) {
                      if (value == null || value.isEmpty) {
                        return "Data harus diisi";
                      } else {
                        return null;
                      }
                    }
                  : (value) {
                      return null;
                    },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide(
                      width: 1.w,
                      color: readOnly ? readOnlyBorderColor : borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide(
                    width: 1.w,
                    color: readOnly
                        ? readOnlyBorderColor
                        : error
                            ? errorColor
                            : primaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide(
                    width: 1.w,
                    color: readOnly ? readOnlyBorderColor : blueBorderColor,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide(width: 1.w, color: errorColor),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide(width: 3.w, color: darkColor),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.h),
                hintText: hintText,
                prefixIcon: prefixIcon == null
                    ? null
                    : Icon(
                        prefixIcon,
                        color: Get.theme.primaryColor,
                      ),
                suffixIcon: isSuffixIcon
                    ? (suffixType == SuffixType.icon
                        ? Icon(suffixIcon)
                        : Padding(
                            padding: EdgeInsets.only(top: 16.h),
                            child: Texts.body2(suffixText!),
                          ))
                    : null,
                filled: true,
                fillColor: readOnly ? readOnlyColor : lightColor,
              ),
            ),
          ),
        ),
        error
            ? AnimatedSize(
                duration: const Duration(milliseconds: 300),
                child: Padding(
                  padding: EdgeInsets.all(1.0.sp),
                  child: Texts.caption(
                    "${errorMessage}",
                    color: Get.theme.colorScheme.error,
                    textOverflow: TextOverflow.visible,
                  ),
                ),
              )
            : SizedBox(),
      ],
    );
  }

  static Widget textFieldDropdown({
    Key? key,
    required TextInputAction textInputAction,
    required TextInputType textInputType,
    required bool isLoading,
    required controller,
    String? hintText,
    TextCapitalization? textCapitalization,
    List<TextInputFormatter>? inputFormatter,
    String? initialValue,
    IconData? prefixIcon,
    bool hasInitialValue = false,
    bool readOnly = false,
    bool isRequired = false,
    bool error = false,
    String? errorMessage,
    String? title,
    Color borderColor = darkColor,
    bool isDropdown = false,
    List<String>? dropdownItems,
    String? dropdownValue,
    ValueChanged<String?>? onDropdownChanged,
    bool isSuffixIcon = false,
    SuffixType suffixType = SuffixType.icon,
    IconData? suffixIcon,
    String? suffixText,
    required bool validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null && title.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Row(
              children: [
                Texts.body2(title),
                if (isRequired) Texts.body2("*", color: Colors.red),
              ],
            ),
          ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: isDropdown
                ? InputDecorator(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.r),
                        borderSide: BorderSide(width: 1.w, color: borderColor),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 10.h),
                      filled: true,
                      fillColor: readOnly ? readOnlyColor : lightColor,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.r),
                        borderSide:
                            BorderSide(width: 1.w, color: MainColorGreen),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.r),
                        borderSide: BorderSide(width: 1.w, color: primaryColor),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        isExpanded: true,
                        isDense: true,
                        onChanged: isLoading ? null : onDropdownChanged,
                        items: dropdownItems
                            ?.map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child:
                                Text(value, style: TextStyle(fontSize: 14.sp)),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                : TextFormField(
                    controller: controller,
                    readOnly: readOnly,
                    cursorColor: Get.theme.primaryColor,
                    inputFormatters: inputFormatter ?? [],
                    enabled: !isLoading,
                    textInputAction: textInputAction,
                    textCapitalization:
                        textCapitalization ?? TextCapitalization.none,
                    keyboardType: textInputType,
                    validator: validator == true
                        ? (value) {
                            if (value == null || value.isEmpty) {
                              return "Data harus diisi";
                            } else {
                              return null;
                            }
                          }
                        : (value) => null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.r),
                        borderSide: BorderSide(
                            width: 1.w,
                            color:
                                readOnly ? readOnlyBorderColor : borderColor),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 10.h),
                      hintText: hintText,
                      prefixIcon: prefixIcon == null
                          ? null
                          : Icon(
                              prefixIcon,
                              color: Get.theme.primaryColor,
                            ),
                      filled: true,
                      fillColor: readOnly ? readOnlyColor : lightColor,
                    ),
                  ),
          ),
        ),
        if (error)
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            child: Padding(
              padding: EdgeInsets.all(1.0.sp),
              child: Texts.caption(
                "${errorMessage}",
                color: Get.theme.colorScheme.error,
                textOverflow: TextOverflow.visible,
              ),
            ),
          ),
      ],
    );
  }

  static Widget defaultTextFieldSuggest({
    Key? key,
    required TextInputAction textInputAction,
    required TextInputType textInputType,
    required bool isLoading,
    required controller,
    String? hintText,
    TextCapitalization? textCapitalization,
    List<TextInputFormatter>? inputFormatter,
    String? initialValue,
    IconData? prefixIcon,
    bool hasInitialValue = false,
    bool readOnly = false,
    bool isRequired = false,
    bool error = false,
    String? errorMessage,
    String? title,
    Color borderColor = darkColor,
    bool isSuffixIcon = false,
    SuffixType suffixType = SuffixType.icon,
    IconData? suffixIcon,
    String? suffixText,
    required bool validator,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null && title.isNotEmpty
            ? isRequired
                ? Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: Row(
                      children: [
                        Texts.body2(title),
                        Texts.body2("*", color: Colors.red),
                      ],
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: Texts.body2(title),
                  )
            : const SizedBox.shrink(),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: TextFormField(
              controller: controller,
              readOnly: readOnly,
              cursorColor: Get.theme.primaryColor,
              inputFormatters: inputFormatter ?? [],
              enabled: !isLoading,
              textInputAction: textInputAction,
              textCapitalization: textCapitalization ?? TextCapitalization.none,
              keyboardType: textInputType,
              onChanged: onChanged,
              validator: validator == true
                  ? (value) {
                      if (value == null || value.isEmpty) {
                        return "Data harus diisi";
                      } else {
                        return null;
                      }
                    }
                  : (value) {
                      return null;
                    },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide(
                      width: 1.w,
                      color: readOnly ? readOnlyBorderColor : borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide(
                    width: 1.w,
                    color: readOnly
                        ? readOnlyBorderColor
                        : error
                            ? errorColor
                            : primaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide(
                    width: 1.w,
                    color: readOnly ? readOnlyBorderColor : blueBorderColor,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide(width: 1.w, color: errorColor),
                ),
                // disabledBorder: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(5.r),
                //   borderSide: BorderSide(width: 3.w, color: darkColor),
                // ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.h),
                hintText: hintText,
                prefixIcon: prefixIcon == null
                    ? null
                    : Icon(
                        prefixIcon,
                        color: Get.theme.primaryColor,
                      ),
                suffixIcon: isSuffixIcon
                    ? (suffixType == SuffixType.icon
                        ? Icon(suffixIcon)
                        : Padding(
                            padding: EdgeInsets.only(top: 16.h),
                            child: Texts.body2(suffixText!),
                          ))
                    : isLoading == true
                        ? Transform.scale(
                            scale:
                                0.5, // Mengatur skala, 0.5 artinya setengah dari ukuran asli
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0, // Ketebalan garis lingkaran
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.blue),
                            ),
                          )
                        : null,
                filled: true,
                fillColor: readOnly ? readOnlyColor : lightColor,
              ),
            ),
          ),
        ),
        error
            ? AnimatedSize(
                duration: const Duration(milliseconds: 300),
                child: Padding(
                  padding: EdgeInsets.all(1.0.sp),
                  child: Texts.caption(
                    "${errorMessage}",
                    color: Get.theme.colorScheme.error,
                    textOverflow: TextOverflow.visible,
                  ),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
