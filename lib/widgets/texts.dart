import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Texts {
  static Text headline1(
    String text, {
    TextAlign textAlign = TextAlign.left,
    TextOverflow textOverflow = TextOverflow.ellipsis,
    Color? color,
    int? maxLines,
    bool isItalic = false,
    bool isUnderline = false,
    bool isOverline = false,
    bool isLineTrough = false,
    bool isBold = false,
  }) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: textOverflow,
      style: TextStyle(
        decoration: (isUnderline && isOverline && isLineTrough)
            ? TextDecoration.combine(
                [
                  TextDecoration.underline,
                  TextDecoration.overline,
                  TextDecoration.lineThrough,
                ],
              )
            : (isUnderline && isOverline)
                ? TextDecoration.combine(
                    [
                      TextDecoration.underline,
                      TextDecoration.overline,
                    ],
                  )
                : (isUnderline && isLineTrough)
                    ? TextDecoration.combine(
                        [
                          TextDecoration.underline,
                          TextDecoration.lineThrough,
                        ],
                      )
                    : (isOverline && isLineTrough)
                        ? TextDecoration.combine(
                            [
                              TextDecoration.overline,
                              TextDecoration.lineThrough,
                            ],
                          )
                        : isUnderline
                            ? TextDecoration.underline
                            : isOverline
                                ? TextDecoration.overline
                                : isLineTrough
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        fontFamily: Platform.isIOS ? 'OpenSans' : 'Roboto',
        fontWeight: isBold ? FontWeight.bold : FontWeight.w300,
        fontSize: 96.0.sp,
        color: color,
        letterSpacing: -1.5,
      ),
    );
  }

  static Text headline2(
    String text, {
    TextAlign textAlign = TextAlign.left,
    Color? color,
    TextOverflow textOverflow = TextOverflow.ellipsis,
    int? maxLines,
    bool isItalic = false,
    bool isUnderline = false,
    bool isOverline = false,
    bool isLineTrough = false,
    bool isBold = false,
  }) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
        decoration: (isUnderline && isOverline && isLineTrough)
            ? TextDecoration.combine(
                [
                  TextDecoration.underline,
                  TextDecoration.overline,
                  TextDecoration.lineThrough,
                ],
              )
            : (isUnderline && isOverline)
                ? TextDecoration.combine(
                    [
                      TextDecoration.underline,
                      TextDecoration.overline,
                    ],
                  )
                : (isUnderline && isLineTrough)
                    ? TextDecoration.combine(
                        [
                          TextDecoration.underline,
                          TextDecoration.lineThrough,
                        ],
                      )
                    : (isOverline && isLineTrough)
                        ? TextDecoration.combine(
                            [
                              TextDecoration.overline,
                              TextDecoration.lineThrough,
                            ],
                          )
                        : isUnderline
                            ? TextDecoration.underline
                            : isOverline
                                ? TextDecoration.overline
                                : isLineTrough
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        fontFamily: Platform.isIOS ? 'OpenSans' : 'Roboto',
        fontWeight: isBold ? FontWeight.bold : FontWeight.w300,
        fontSize: 60.sp,
        color: color,
        letterSpacing: -0.5,
      ),
    );
  }

  static Text headline3(
    String text, {
    TextAlign textAlign = TextAlign.left,
    TextDecoration decoration = TextDecoration.none,
    Color? color,
    TextOverflow textOverflow = TextOverflow.ellipsis,
    int? maxLines,
    bool isItalic = false,
    bool isUnderline = false,
    bool isOverline = false,
    bool isLineTrough = false,
    bool isBold = false,
  }) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: textOverflow,
      style: TextStyle(
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        fontFamily: Platform.isIOS ? 'OpenSans' : 'Roboto',
        fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
        fontSize: 48.sp,
        color: color,
        letterSpacing: 0.0,
        decoration: (isUnderline && isOverline && isLineTrough)
            ? TextDecoration.combine(
                [
                  TextDecoration.underline,
                  TextDecoration.overline,
                  TextDecoration.lineThrough,
                ],
              )
            : (isUnderline && isOverline)
                ? TextDecoration.combine(
                    [
                      TextDecoration.underline,
                      TextDecoration.overline,
                    ],
                  )
                : (isUnderline && isLineTrough)
                    ? TextDecoration.combine(
                        [
                          TextDecoration.underline,
                          TextDecoration.lineThrough,
                        ],
                      )
                    : (isOverline && isLineTrough)
                        ? TextDecoration.combine(
                            [
                              TextDecoration.overline,
                              TextDecoration.lineThrough,
                            ],
                          )
                        : isUnderline
                            ? TextDecoration.underline
                            : isOverline
                                ? TextDecoration.overline
                                : isLineTrough
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
      ),
    );
  }

  static Text headline4(
    String text, {
    TextAlign textAlign = TextAlign.left,
    TextDecoration decoration = TextDecoration.none,
    Color? color,
    TextOverflow textOverflow = TextOverflow.ellipsis,
    int? maxLines,
    bool isItalic = false,
    bool isUnderline = false,
    bool isOverline = false,
    bool isLineTrough = false,
    bool isBold = false,
  }) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: textOverflow,
      style: TextStyle(
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        fontFamily: Platform.isIOS ? 'OpenSans' : 'Roboto',
        fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
        fontSize: 34.sp,
        color: color,
        letterSpacing: 0.25,
        decoration: (isUnderline && isOverline && isLineTrough)
            ? TextDecoration.combine(
                [
                  TextDecoration.underline,
                  TextDecoration.overline,
                  TextDecoration.lineThrough,
                ],
              )
            : (isUnderline && isOverline)
                ? TextDecoration.combine(
                    [
                      TextDecoration.underline,
                      TextDecoration.overline,
                    ],
                  )
                : (isUnderline && isLineTrough)
                    ? TextDecoration.combine(
                        [
                          TextDecoration.underline,
                          TextDecoration.lineThrough,
                        ],
                      )
                    : (isOverline && isLineTrough)
                        ? TextDecoration.combine(
                            [
                              TextDecoration.overline,
                              TextDecoration.lineThrough,
                            ],
                          )
                        : isUnderline
                            ? TextDecoration.underline
                            : isOverline
                                ? TextDecoration.overline
                                : isLineTrough
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
      ),
    );
  }

  static Text headline5(
    String text, {
    TextAlign textAlign = TextAlign.left,
    TextDecoration decoration = TextDecoration.none,
    Color? color,
    TextOverflow textOverflow = TextOverflow.ellipsis,
    int? maxLines,
    bool isItalic = false,
    bool isUnderline = false,
    bool isOverline = false,
    bool isLineTrough = false,
    bool isBold = false,
  }) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: textOverflow,
      style: TextStyle(
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        fontFamily: Platform.isIOS ? 'OpenSans' : 'Roboto',
        fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
        fontSize: 24.sp,
        color: color,
        letterSpacing: 0.0,
        decoration: (isUnderline && isOverline && isLineTrough)
            ? TextDecoration.combine(
                [
                  TextDecoration.underline,
                  TextDecoration.overline,
                  TextDecoration.lineThrough,
                ],
              )
            : (isUnderline && isOverline)
                ? TextDecoration.combine(
                    [
                      TextDecoration.underline,
                      TextDecoration.overline,
                    ],
                  )
                : (isUnderline && isLineTrough)
                    ? TextDecoration.combine(
                        [
                          TextDecoration.underline,
                          TextDecoration.lineThrough,
                        ],
                      )
                    : (isOverline && isLineTrough)
                        ? TextDecoration.combine(
                            [
                              TextDecoration.overline,
                              TextDecoration.lineThrough,
                            ],
                          )
                        : isUnderline
                            ? TextDecoration.underline
                            : isOverline
                                ? TextDecoration.overline
                                : isLineTrough
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
      ),
    );
  }

  static Text headline6(
    String text, {
    TextAlign textAlign = TextAlign.left,
    TextDecoration decoration = TextDecoration.none,
    Color? color,
    TextOverflow textOverflow = TextOverflow.ellipsis,
    int? maxLines,
    bool isItalic = false,
    bool isUnderline = false,
    bool isOverline = false,
    bool isLineTrough = false,
    bool isBold = false,
  }) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: textOverflow,
      style: TextStyle(
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        fontFamily: Platform.isIOS ? 'OpenSans' : 'Roboto',
        fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
        fontSize: 19.sp,
        color: color,
        letterSpacing: 0.15,
        decoration: (isUnderline && isOverline && isLineTrough)
            ? TextDecoration.combine(
                [
                  TextDecoration.underline,
                  TextDecoration.overline,
                  TextDecoration.lineThrough,
                ],
              )
            : (isUnderline && isOverline)
                ? TextDecoration.combine(
                    [
                      TextDecoration.underline,
                      TextDecoration.overline,
                    ],
                  )
                : (isUnderline && isLineTrough)
                    ? TextDecoration.combine(
                        [
                          TextDecoration.underline,
                          TextDecoration.lineThrough,
                        ],
                      )
                    : (isOverline && isLineTrough)
                        ? TextDecoration.combine(
                            [
                              TextDecoration.overline,
                              TextDecoration.lineThrough,
                            ],
                          )
                        : isUnderline
                            ? TextDecoration.underline
                            : isOverline
                                ? TextDecoration.overline
                                : isLineTrough
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
      ),
    );
  }

  static Text appBarText(
    String text, {
    TextAlign textAlign = TextAlign.center,
    TextDecoration decoration = TextDecoration.none,
    Color? color,
    TextOverflow textOverflow = TextOverflow.ellipsis,
    int? maxLines,
    bool isItalic = false,
    bool isUnderline = false,
    bool isOverline = false,
    bool isLineTrough = false,
    bool isBold = false,
  }) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: textOverflow,
      style: TextStyle(
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        fontFamily: Platform.isIOS ? 'OpenSans' : 'Roboto',
        fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
        fontSize: 16.0.sp,
        color: color,
        letterSpacing: 0.15,
        decoration: (isUnderline && isOverline && isLineTrough)
            ? TextDecoration.combine(
                [
                  TextDecoration.underline,
                  TextDecoration.overline,
                  TextDecoration.lineThrough,
                ],
              )
            : (isUnderline && isOverline)
                ? TextDecoration.combine(
                    [
                      TextDecoration.underline,
                      TextDecoration.overline,
                    ],
                  )
                : (isUnderline && isLineTrough)
                    ? TextDecoration.combine(
                        [
                          TextDecoration.underline,
                          TextDecoration.lineThrough,
                        ],
                      )
                    : (isOverline && isLineTrough)
                        ? TextDecoration.combine(
                            [
                              TextDecoration.overline,
                              TextDecoration.lineThrough,
                            ],
                          )
                        : isUnderline
                            ? TextDecoration.underline
                            : isOverline
                                ? TextDecoration.overline
                                : isLineTrough
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
      ),
    );
  }

  static Text subtitle2(
    String text, {
    TextAlign textAlign = TextAlign.left,
    TextDecoration decoration = TextDecoration.none,
    Color? color,
    TextOverflow textOverflow = TextOverflow.ellipsis,
    int? maxLines,
    bool isItalic = false,
    bool isUnderline = false,
    bool isOverline = false,
    bool isLineTrough = false,
    bool isBold = false,
  }) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: textOverflow,
      style: TextStyle(
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        fontFamily: Platform.isIOS ? 'OpenSans' : 'Roboto',
        fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
        fontSize: 14.0.sp,
        color: color,
        letterSpacing: 0.1,
        decoration: (isUnderline && isOverline && isLineTrough)
            ? TextDecoration.combine(
                [
                  TextDecoration.underline,
                  TextDecoration.overline,
                  TextDecoration.lineThrough,
                ],
              )
            : (isUnderline && isOverline)
                ? TextDecoration.combine(
                    [
                      TextDecoration.underline,
                      TextDecoration.overline,
                    ],
                  )
                : (isUnderline && isLineTrough)
                    ? TextDecoration.combine(
                        [
                          TextDecoration.underline,
                          TextDecoration.lineThrough,
                        ],
                      )
                    : (isOverline && isLineTrough)
                        ? TextDecoration.combine(
                            [
                              TextDecoration.overline,
                              TextDecoration.lineThrough,
                            ],
                          )
                        : isUnderline
                            ? TextDecoration.underline
                            : isOverline
                                ? TextDecoration.overline
                                : isLineTrough
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
      ),
    );
  }

  static Text body1(
    String text, {
    TextAlign textAlign = TextAlign.left,
    TextDecoration decoration = TextDecoration.none,
    Color? color,
    TextOverflow textOverflow = TextOverflow.ellipsis,
    int? maxLines,
    bool isItalic = false,
    bool isUnderline = false,
    bool isOverline = false,
    bool isLineTrough = false,
    bool isBold = false,
  }) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: textOverflow,
      style: TextStyle(
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        fontFamily: Platform.isIOS ? 'OpenSans' : 'Roboto',
        fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
        fontSize: 15.5.sp,
        color: color,
        letterSpacing: 0.5,
        decoration: (isUnderline && isOverline && isLineTrough)
            ? TextDecoration.combine(
                [
                  TextDecoration.underline,
                  TextDecoration.overline,
                  TextDecoration.lineThrough,
                ],
              )
            : (isUnderline && isOverline)
                ? TextDecoration.combine(
                    [
                      TextDecoration.underline,
                      TextDecoration.overline,
                    ],
                  )
                : (isUnderline && isLineTrough)
                    ? TextDecoration.combine(
                        [
                          TextDecoration.underline,
                          TextDecoration.lineThrough,
                        ],
                      )
                    : (isOverline && isLineTrough)
                        ? TextDecoration.combine(
                            [
                              TextDecoration.overline,
                              TextDecoration.lineThrough,
                            ],
                          )
                        : isUnderline
                            ? TextDecoration.underline
                            : isOverline
                                ? TextDecoration.overline
                                : isLineTrough
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
      ),
    );
  }

  static Text body2(
    String text, {
    TextAlign textAlign = TextAlign.left,
    TextDecoration decoration = TextDecoration.none,
    Color? color,
    TextOverflow textOverflow = TextOverflow.ellipsis,
    int? maxLines,
    bool isItalic = false,
    bool isUnderline = false,
    bool isOverline = false,
    bool isLineTrough = false,
    bool isBold = false,
  }) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: textOverflow,
      style: TextStyle(
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        fontFamily: Platform.isIOS ? 'OpenSans' : 'Roboto',
        fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
        fontSize: 14.0.sp,
        color: color,
        letterSpacing: 0.25,
        decoration: (isUnderline && isOverline && isLineTrough)
            ? TextDecoration.combine(
                [
                  TextDecoration.underline,
                  TextDecoration.overline,
                  TextDecoration.lineThrough,
                ],
              )
            : (isUnderline && isOverline)
                ? TextDecoration.combine(
                    [
                      TextDecoration.underline,
                      TextDecoration.overline,
                    ],
                  )
                : (isUnderline && isLineTrough)
                    ? TextDecoration.combine(
                        [
                          TextDecoration.underline,
                          TextDecoration.lineThrough,
                        ],
                      )
                    : (isOverline && isLineTrough)
                        ? TextDecoration.combine(
                            [
                              TextDecoration.overline,
                              TextDecoration.lineThrough,
                            ],
                          )
                        : isUnderline
                            ? TextDecoration.underline
                            : isOverline
                                ? TextDecoration.overline
                                : isLineTrough
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
      ),
    );
  }

  static Text button(
    String text, {
    TextAlign textAlign = TextAlign.left,
    TextDecoration decoration = TextDecoration.none,
    Color? color,
    TextOverflow textOverflow = TextOverflow.ellipsis,
    int? maxLines,
    bool isItalic = false,
    bool isUnderline = false,
    bool isOverline = false,
    bool isLineTrough = false,
    bool isBold = false,
  }) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: textOverflow,
      style: TextStyle(
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        fontFamily: Platform.isIOS ? 'OpenSans' : 'Roboto',
        fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
        fontSize: 14.0.sp,
        color: color,
        letterSpacing: 1.25,
        decoration: (isUnderline && isOverline && isLineTrough)
            ? TextDecoration.combine(
                [
                  TextDecoration.underline,
                  TextDecoration.overline,
                  TextDecoration.lineThrough,
                ],
              )
            : (isUnderline && isOverline)
                ? TextDecoration.combine(
                    [
                      TextDecoration.underline,
                      TextDecoration.overline,
                    ],
                  )
                : (isUnderline && isLineTrough)
                    ? TextDecoration.combine(
                        [
                          TextDecoration.underline,
                          TextDecoration.lineThrough,
                        ],
                      )
                    : (isOverline && isLineTrough)
                        ? TextDecoration.combine(
                            [
                              TextDecoration.overline,
                              TextDecoration.lineThrough,
                            ],
                          )
                        : isUnderline
                            ? TextDecoration.underline
                            : isOverline
                                ? TextDecoration.overline
                                : isLineTrough
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
      ),
    );
  }

  static Text caption(
    String text, {
    TextAlign textAlign = TextAlign.left,
    TextDecoration decoration = TextDecoration.none,
    Color? color,
    TextOverflow textOverflow = TextOverflow.ellipsis,
    int? maxLines,
    bool isItalic = false,
    bool isUnderline = false,
    bool isOverline = false,
    bool isLineTrough = false,
    bool isBold = false,
  }) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: textOverflow,
      style: TextStyle(
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        fontFamily: Platform.isIOS ? 'OpenSans' : 'Roboto',
        fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
        fontSize: 13.sp,
        color: color,
        letterSpacing: 0.4,
        decoration: (isUnderline && isOverline && isLineTrough)
            ? TextDecoration.combine(
                [
                  TextDecoration.underline,
                  TextDecoration.overline,
                  TextDecoration.lineThrough,
                ],
              )
            : (isUnderline && isOverline)
                ? TextDecoration.combine(
                    [
                      TextDecoration.underline,
                      TextDecoration.overline,
                    ],
                  )
                : (isUnderline && isLineTrough)
                    ? TextDecoration.combine(
                        [
                          TextDecoration.underline,
                          TextDecoration.lineThrough,
                        ],
                      )
                    : (isOverline && isLineTrough)
                        ? TextDecoration.combine(
                            [
                              TextDecoration.overline,
                              TextDecoration.lineThrough,
                            ],
                          )
                        : isUnderline
                            ? TextDecoration.underline
                            : isOverline
                                ? TextDecoration.overline
                                : isLineTrough
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
      ),
    );
  }

  static Text captionSm(
    String text, {
    TextAlign textAlign = TextAlign.left,
    TextDecoration decoration = TextDecoration.none,
    Color? color,
    TextOverflow textOverflow = TextOverflow.ellipsis,
    int? maxLines,
    bool isItalic = false,
    bool isUnderline = false,
    bool isOverline = false,
    bool isLineTrough = false,
    bool isBold = false,
  }) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: textOverflow,
      style: TextStyle(
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        fontFamily: Platform.isIOS ? 'OpenSans' : 'Roboto',
        fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
        fontSize: 10.8.sp,
        color: color,
        letterSpacing: 0.4,
        decoration: (isUnderline && isOverline && isLineTrough)
            ? TextDecoration.combine(
                [
                  TextDecoration.underline,
                  TextDecoration.overline,
                  TextDecoration.lineThrough,
                ],
              )
            : (isUnderline && isOverline)
                ? TextDecoration.combine(
                    [
                      TextDecoration.underline,
                      TextDecoration.overline,
                    ],
                  )
                : (isUnderline && isLineTrough)
                    ? TextDecoration.combine(
                        [
                          TextDecoration.underline,
                          TextDecoration.lineThrough,
                        ],
                      )
                    : (isOverline && isLineTrough)
                        ? TextDecoration.combine(
                            [
                              TextDecoration.overline,
                              TextDecoration.lineThrough,
                            ],
                          )
                        : isUnderline
                            ? TextDecoration.underline
                            : isOverline
                                ? TextDecoration.overline
                                : isLineTrough
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
      ),
    );
  }

  static Text textESPPT(
    String text, {
    TextAlign textAlign = TextAlign.left,
    TextDecoration decoration = TextDecoration.none,
    Color? color,
    TextOverflow textOverflow = TextOverflow.ellipsis,
    int? maxLines,
    bool isItalic = false,
    bool isUnderline = false,
    bool isOverline = false,
    bool isLineTrough = false,
    bool isBold = false,
  }) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: textOverflow,
      style: TextStyle(
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        fontFamily: Platform.isIOS ? 'OpenSans' : 'Roboto',
        fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
        fontSize: 7.0.sp,
        color: color,
        letterSpacing: 0.4,
        decoration: (isUnderline && isOverline && isLineTrough)
            ? TextDecoration.combine(
                [
                  TextDecoration.underline,
                  TextDecoration.overline,
                  TextDecoration.lineThrough,
                ],
              )
            : (isUnderline && isOverline)
                ? TextDecoration.combine(
                    [
                      TextDecoration.underline,
                      TextDecoration.overline,
                    ],
                  )
                : (isUnderline && isLineTrough)
                    ? TextDecoration.combine(
                        [
                          TextDecoration.underline,
                          TextDecoration.lineThrough,
                        ],
                      )
                    : (isOverline && isLineTrough)
                        ? TextDecoration.combine(
                            [
                              TextDecoration.overline,
                              TextDecoration.lineThrough,
                            ],
                          )
                        : isUnderline
                            ? TextDecoration.underline
                            : isOverline
                                ? TextDecoration.overline
                                : isLineTrough
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
      ),
    );
  }

  static Text captionDashboard(
    String text, {
    TextAlign textAlign = TextAlign.left,
    TextDecoration decoration = TextDecoration.none,
    Color? color,
    TextOverflow textOverflow = TextOverflow.ellipsis,
    int? maxLines,
    bool isItalic = false,
    bool isUnderline = false,
    bool isOverline = false,
    bool isLineTrough = false,
    bool isBold = false,
  }) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: textOverflow,
      style: TextStyle(
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
        fontSize: 12.sp,
        color: color,
        letterSpacing: 0.4,
        decoration: (isUnderline && isOverline && isLineTrough)
            ? TextDecoration.combine(
                [
                  TextDecoration.underline,
                  TextDecoration.overline,
                  TextDecoration.lineThrough,
                ],
              )
            : (isUnderline && isOverline)
                ? TextDecoration.combine(
                    [
                      TextDecoration.underline,
                      TextDecoration.overline,
                    ],
                  )
                : (isUnderline && isLineTrough)
                    ? TextDecoration.combine(
                        [
                          TextDecoration.underline,
                          TextDecoration.lineThrough,
                        ],
                      )
                    : (isOverline && isLineTrough)
                        ? TextDecoration.combine(
                            [
                              TextDecoration.overline,
                              TextDecoration.lineThrough,
                            ],
                          )
                        : isUnderline
                            ? TextDecoration.underline
                            : isOverline
                                ? TextDecoration.overline
                                : isLineTrough
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
      ),
    );
  }

  static Text captionXs(
    String text, {
    TextAlign textAlign = TextAlign.left,
    TextDecoration decoration = TextDecoration.none,
    Color? color,
    TextOverflow textOverflow = TextOverflow.ellipsis,
    int? maxLines,
    bool isItalic = false,
    bool isUnderline = false,
    bool isOverline = false,
    bool isLineTrough = false,
    bool isBold = false,
  }) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: textOverflow,
      style: TextStyle(
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        fontFamily: Platform.isIOS ? 'OpenSans' : 'Roboto',
        fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
        fontSize: 8.sp,
        color: color,
        letterSpacing: 0.4,
        decoration: (isUnderline && isOverline && isLineTrough)
            ? TextDecoration.combine(
                [
                  TextDecoration.underline,
                  TextDecoration.overline,
                  TextDecoration.lineThrough,
                ],
              )
            : (isUnderline && isOverline)
                ? TextDecoration.combine(
                    [
                      TextDecoration.underline,
                      TextDecoration.overline,
                    ],
                  )
                : (isUnderline && isLineTrough)
                    ? TextDecoration.combine(
                        [
                          TextDecoration.underline,
                          TextDecoration.lineThrough,
                        ],
                      )
                    : (isOverline && isLineTrough)
                        ? TextDecoration.combine(
                            [
                              TextDecoration.overline,
                              TextDecoration.lineThrough,
                            ],
                          )
                        : isUnderline
                            ? TextDecoration.underline
                            : isOverline
                                ? TextDecoration.overline
                                : isLineTrough
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
      ),
    );
  }

  static Text captionXs2(
    String text, {
    TextAlign textAlign = TextAlign.left,
    TextDecoration decoration = TextDecoration.none,
    Color? color,
    TextOverflow textOverflow = TextOverflow.ellipsis,
    int? maxLines,
    bool isItalic = false,
    bool isUnderline = false,
    bool isOverline = false,
    bool isLineTrough = false,
    bool isBold = false,
  }) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: textOverflow,
      style: TextStyle(
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        fontFamily: Platform.isIOS ? 'OpenSans' : 'Roboto',
        fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
        fontSize: 10.sp,
        color: color,
        letterSpacing: 0.4,
        decoration: (isUnderline && isOverline && isLineTrough)
            ? TextDecoration.combine(
                [
                  TextDecoration.underline,
                  TextDecoration.overline,
                  TextDecoration.lineThrough,
                ],
              )
            : (isUnderline && isOverline)
                ? TextDecoration.combine(
                    [
                      TextDecoration.underline,
                      TextDecoration.overline,
                    ],
                  )
                : (isUnderline && isLineTrough)
                    ? TextDecoration.combine(
                        [
                          TextDecoration.underline,
                          TextDecoration.lineThrough,
                        ],
                      )
                    : (isOverline && isLineTrough)
                        ? TextDecoration.combine(
                            [
                              TextDecoration.overline,
                              TextDecoration.lineThrough,
                            ],
                          )
                        : isUnderline
                            ? TextDecoration.underline
                            : isOverline
                                ? TextDecoration.overline
                                : isLineTrough
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
      ),
    );
  }

  static Text overline(
    String text, {
    TextAlign textAlign = TextAlign.left,
    TextDecoration decoration = TextDecoration.none,
    Color? color,
    TextOverflow textOverflow = TextOverflow.ellipsis,
    int? maxLines,
    bool isItalic = false,
    bool isUnderline = false,
    bool isOverline = false,
    bool isLineTrough = false,
    bool isBold = false,
  }) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: textOverflow,
      style: TextStyle(
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        fontFamily: Platform.isIOS ? 'OpenSans' : 'Roboto',
        fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
        fontSize: 10.0.sp,
        color: color,
        letterSpacing: 1.5,
        decoration: (isUnderline && isOverline && isLineTrough)
            ? TextDecoration.combine(
                [
                  TextDecoration.underline,
                  TextDecoration.overline,
                  TextDecoration.lineThrough,
                ],
              )
            : (isUnderline && isOverline)
                ? TextDecoration.combine(
                    [
                      TextDecoration.underline,
                      TextDecoration.overline,
                    ],
                  )
                : (isUnderline && isLineTrough)
                    ? TextDecoration.combine(
                        [
                          TextDecoration.underline,
                          TextDecoration.lineThrough,
                        ],
                      )
                    : (isOverline && isLineTrough)
                        ? TextDecoration.combine(
                            [
                              TextDecoration.overline,
                              TextDecoration.lineThrough,
                            ],
                          )
                        : isUnderline
                            ? TextDecoration.underline
                            : isOverline
                                ? TextDecoration.overline
                                : isLineTrough
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
      ),
    );
  }

  // static Text subheads(
  //   String text, {
  //   TextAlign textAlign = TextAlign.left,
  //   Color? color,
  //   TextOverflow textOverflow = TextOverflow.ellipsis,
  //   int? maxLines,
  //   bool isItalic = false,
  //   bool isUnderline = false,
  //   bool isOverline = false,
  //   bool isLineTrough = false,
  //   bool isBold = false,
  // }) {
  //   return Text(
  //     text,
  //     maxLines: maxLines,
  //     textAlign: textAlign,
  //     style: TextStyle(
  //       decoration: TextDecoration.combine(
  //         [
  //           isUnderline ? TextDecoration.underline : TextDecoration.none,
  //           isOverline ? TextDecoration.overline : TextDecoration.none,
  //           isLineTrough ? TextDecoration.lineThrough : TextDecoration.none,
  //         ],
  //       ),
  //       fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
  //       fontFamily: Platform.isIOS ? 'OpenSans' : 'Roboto',
  //       fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
  //       fontSize: 16.sp,
  //       color: color,
  //     ),
  //   );
  // }

  // static Text text(
  //   String text, {
  //   TextAlign textAlign = TextAlign.left,
  //   TextOverflow textOverflow = TextOverflow.ellipsis,
  //   Color? color,
  //   int? maxLines,
  //   bool isItalic = false,
  //   bool isUnderline = false,
  //   bool isOverline = false,
  //   bool isLineTrough = false,
  //   bool isBold = false,
  // }) {
  //   return Text(
  //     text,
  //     maxLines: maxLines,
  //     softWrap: true,
  //     overflow: textOverflow,
  //     textAlign: textAlign,
  //     style: TextStyle(
  //       decoration: TextDecoration.combine(
  //         [
  //           isUnderline ? TextDecoration.underline : TextDecoration.none,
  //           isOverline ? TextDecoration.overline : TextDecoration.none,
  //           isLineTrough ? TextDecoration.lineThrough : TextDecoration.none,
  //         ],
  //       ),
  //       fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
  //       height: 1.1,
  //       fontFamily: Platform.isIOS ? 'OpenSans' : 'Roboto',
  //       fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
  //       fontSize: 16.sp,
  //       color: color,
  //     ),
  //   );
  // }

  // static Text descriptiveItems(
  //   String text, {
  //   TextAlign textAlign = TextAlign.left,
  //   TextDecoration decoration = TextDecoration.none,
  //   Color? color,
  //   TextOverflow textOverflow = TextOverflow.ellipsis,
  //   int? maxLines,
  //   bool isItalic = false,
  //   bool isUnderline = false,
  //   bool isOverline = false,
  //   bool isLineTrough = false,
  //   bool isBold = false,
  // }) {
  //   return Text(
  //     text,
  //     maxLines: maxLines,
  //     textAlign: textAlign,
  //     style: TextStyle(
  //       decoration: TextDecoration.combine(
  //         [
  //           isUnderline ? TextDecoration.underline : TextDecoration.none,
  //           isOverline ? TextDecoration.overline : TextDecoration.none,
  //           isLineTrough ? TextDecoration.lineThrough : TextDecoration.none,
  //         ],
  //       ),
  //       fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
  //       decorationThickness: 5,
  //       fontFamily: Platform.isIOS ? 'OpenSans' : 'Roboto',
  //       fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
  //       fontSize: 14.sp,
  //       color: color,
  //     ),
  //   );
  // }

  // static Text descriptiveItems2(
  //   String text, {
  //   TextAlign textAlign = TextAlign.left,
  //   TextDecoration decoration = TextDecoration.none,
  //   Color? color,
  //   TextOverflow textOverflow = TextOverflow.ellipsis,
  //   int? maxLines,
  //   bool isItalic = false,
  //   bool isUnderline = false,
  //   bool isOverline = false,
  //   bool isLineTrough = false,
  //   bool isBold = false,
  // }) {
  //   return Text(
  //     text,
  //     maxLines: maxLines,
  //     textAlign: textAlign,
  //     overflow: TextOverflow.visible,
  //     style: TextStyle(
  //         decoration: (isUnderline && isOverline && isLineTrough)
  //             ? TextDecoration.combine(
  //                 [
  //                   TextDecoration.underline,
  //                   TextDecoration.overline,
  //                   TextDecoration.lineThrough,
  //                 ],
  //               )
  //             : (isUnderline && isOverline)
  //                 ? TextDecoration.combine(
  //                     [
  //                       TextDecoration.underline,
  //                       TextDecoration.overline,
  //                     ],
  //                   )
  //                 : (isUnderline && isLineTrough)
  //                     ? TextDecoration.combine(
  //                         [
  //                           TextDecoration.underline,
  //                           TextDecoration.lineThrough,
  //                         ],
  //                       )
  //                     : (isOverline && isLineTrough)
  //                         ? TextDecoration.combine(
  //                             [
  //                               TextDecoration.overline,
  //                               TextDecoration.lineThrough,
  //                             ],
  //                           )
  //                         : isUnderline
  //                             ? TextDecoration.underline
  //                             : isOverline
  //                                 ? TextDecoration.overline
  //                                 : isLineTrough
  //                                     ? TextDecoration.lineThrough
  //                                     : TextDecoration.none,
  //         fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
  //         decorationThickness: 5,
  //         fontFamily: Platform.isIOS ? 'OpenSans' : 'Roboto',
  //         fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
  //         fontSize: 10.sp,
  //         color: color),
  //   );
  // }

  // static Text descriptionText(
  //   String text, {
  //   TextAlign textAlign = TextAlign.left,
  //   Color? color,
  //   TextOverflow textOverflow = TextOverflow.ellipsis,
  //   int? maxLines,
  //   bool isItalic = false,
  //   bool isUnderline = false,
  //   bool isOverline = false,
  //   bool isLineTrough = false,
  //   bool isBold = false,
  // }) {
  //   return Text(
  //     text,
  //     maxLines: maxLines,
  //     textAlign: textAlign,
  //     style: TextStyle(
  //       decoration: TextDecoration.combine(
  //         [
  //           isUnderline ? TextDecoration.underline : TextDecoration.none,
  //           isOverline ? TextDecoration.overline : TextDecoration.none,
  //           isLineTrough ? TextDecoration.lineThrough : TextDecoration.none,
  //         ],
  //       ),
  //       fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
  //       fontFamily: Platform.isIOS ? 'OpenSans' : 'Roboto',
  //       fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
  //       fontSize: 14.sp,
  //       color: color,
  //     ),
  //   );
  // }

  // static Text helperText(
  //   String text, {
  //   TextAlign textAlign = TextAlign.left,
  //   TextOverflow overflow = TextOverflow.clip,
  //   Color? color,
  //   TextOverflow textOverflow = TextOverflow.ellipsis,
  //   int? maxLines,
  //   bool isItalic = false,
  //   bool isUnderline = false,
  //   bool isOverline = false,
  //   bool isLineTrough = false,
  //   bool isBold = false,
  // }) {
  //   return Text(
  //     text,
  //     maxLines: maxLines,
  //     textAlign: textAlign,
  //     overflow: overflow,
  //     style: TextStyle(
  //       decoration: TextDecoration.combine(
  //         [
  //           isUnderline ? TextDecoration.underline : TextDecoration.none,
  //           isOverline ? TextDecoration.overline : TextDecoration.none,
  //           isLineTrough ? TextDecoration.lineThrough : TextDecoration.none,
  //         ],
  //       ),
  //       fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
  //       fontFamily: Platform.isIOS ? 'OpenSans' : 'Roboto',
  //       fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
  //       fontSize: 11.sp,
  //       color: color,
  //     ),
  //   );
  // }
}
