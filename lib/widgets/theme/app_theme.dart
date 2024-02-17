import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const Color kBgColor = Color.fromARGB(255, 217, 241, 251);
const Color lightTextColor = Color.fromRGBO(95, 102, 97, 1);
const Color veryLightTextColor = Color.fromRGBO(170, 170, 180, 1);
const Color textLink = Color.fromARGB(255, 54, 144, 223);
const Color lightGreenColor = Color.fromRGBO(104, 167, 175, 1);
const Color lightBlueColor = Color(0xFF2CB1C4);
const Color lightRedColor = Color.fromRGBO(173, 90, 74, 1);
const Color darkTextColor = Color.fromRGBO(34, 64, 67, 1);
const Color greyBackground = Color.fromRGBO(247, 247, 250, 1);
const Color MainColor = Color(0xFF002c55);
const Color MainColorGreen = Color(0xFF39D2C0);
const Color SecMainColor = Color(0xFF8DA9C4);
const Color correctData = Color(0xFF39D2C0);
const Color Blacksoft = Color.fromARGB(255, 46, 46, 46);
const primaryColor = Color(0xFF006CB8);
const secondaryColor = Color(0xFF267AA7);
const scaffoldColor = Colors.white;
const backgroundColor = Colors.white;
const lightColor = Colors.white;
const darkColor = Colors.black;
const errorColor = Colors.red;
const shadowColor = Colors.grey;
const correctColor = Colors.green;
const textColor = Colors.black;
const backgroundColorDark = Color(0xFF1f1f1f);
const shadowText = Color(0XFF616161);
const appBarColor = Color(0XFFF1F5FB);
const shadowColor2 = Color(0XFFEDEDED);
const shadowColor3 = Color(0XFFC2C2C2);
const readOnlyColor = Color(0XFFF5F5F5);
const greenColor = Color(0XFF84BD00);
const readOnlyBorderColor = Color(0XFFE0E0E0);
const transparent = Colors.transparent;
const blueBorderColor = Color(0XFFBAD5F9);
const unverifiedBackgroundColor = Color(0XFFF2CCCC);
const unverifiedTextColor = Color(0XFFBD0000);
const verifiedBackgroundColor = Color(0XFFCFF2CC);
const verifiedTextColor = Color(0XFF0FBD00);
const needConfirmationTextColor = Color(0XFF616161);
const borderFieldColor = Color(0XFFEAEAEA);
const deleteColor = Color(0XFF952d2d);
const deleteBorderColor = Color(0XFFda8181);
List<Color> gradientColor = [Colors.cyan, Color.fromARGB(255, 77, 103, 197)];

var fontCard = TextStyle(
    fontSize: 12.sp, color: lightTextColor, fontWeight: FontWeight.w600);

ThemeData lightTheme = ThemeData(
  shadowColor: shadowColor,
  appBarTheme: const AppBarTheme(backgroundColor: primaryColor),
  brightness: Brightness.light,
  primaryColor: primaryColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shadowColor: MaterialStateProperty.all<Color?>(shadowColor),
      backgroundColor: MaterialStateProperty.all<Color?>(primaryColor),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      overlayColor:
          MaterialStateProperty.all<Color?>(primaryColor.withAlpha(50)),
      foregroundColor: MaterialStateProperty.all<Color?>(primaryColor),
      // backgroundColor: MaterialStateProperty.all<Color?>(primaryColor),
      // surfaceTintColor: MaterialStateProperty.all<Color?>(primaryColor),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    iconColor: primaryColor,
    fillColor: backgroundColor,
    suffixIconColor: primaryColor,
    prefixIconColor: primaryColor,
    labelStyle: TextStyle(
      color: Colors.grey.shade600,
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.all<Color?>(primaryColor),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: textColor),
    displayMedium: TextStyle(color: textColor),
    displaySmall: TextStyle(color: textColor),
    headlineLarge: TextStyle(color: textColor),
    headlineMedium: TextStyle(color: textColor),
    headlineSmall: TextStyle(color: textColor),
    bodyLarge: TextStyle(color: textColor),
    bodyMedium: TextStyle(color: textColor),
    bodySmall: TextStyle(color: textColor),
    titleSmall: TextStyle(color: textColor),
    titleMedium: TextStyle(color: textColor),
    titleLarge: TextStyle(color: textColor),
    labelSmall: TextStyle(color: textColor),
    labelMedium: TextStyle(color: textColor),
    labelLarge: TextStyle(color: textColor),
  ),
  navigationBarTheme: NavigationBarThemeData(
    labelTextStyle: MaterialStateProperty.all<TextStyle>(
      const TextStyle(
        color: primaryColor,
      ),
    ),
  ),
  listTileTheme: const ListTileThemeData(
    tileColor: backgroundColor,
  ),
  dividerColor: shadowColor,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: backgroundColor,
    unselectedLabelStyle: TextStyle(
      color: shadowColor,
    ),
    selectedItemColor: primaryColor,
    selectedIconTheme: IconThemeData(
      color: primaryColor,
    ),
    unselectedIconTheme: IconThemeData(
      color: shadowColor,
    ),
    selectedLabelStyle: TextStyle(
      color: primaryColor,
    ),
    unselectedItemColor: shadowColor,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: primaryColor,
    foregroundColor: backgroundColor,
  ),
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: primaryColor,
    onPrimary: Colors.white,
    secondary: Colors.blue.shade900,
    onSecondary: Colors.yellow.withAlpha(100),
    error: errorColor,
    onError: errorColor.withAlpha(100),
    background: backgroundColor,
    onBackground: darkColor,
    surface: backgroundColor,
    onSurface: shadowColor,
  ),
);

ThemeData darkTheme = ThemeData(
  shadowColor: backgroundColorDark,
  brightness: Brightness.dark,
  primaryColor: Colors.grey,
  scaffoldBackgroundColor: const Color(0xFF1f1f1f),
  inputDecorationTheme: const InputDecorationTheme(
    fillColor: backgroundColorDark,
    suffixIconColor: Colors.grey,
    prefixIconColor: Colors.grey,
    labelStyle: TextStyle(
      color: Colors.grey,
    ),
    iconColor: primaryColor,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      // shadowColor: MaterialStateProperty.all<Color?>(shadowColor),
      backgroundColor: MaterialStateProperty.all<Color?>(primaryColor),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      // shadowColor: MaterialStateProperty.all<Color?>(shadowColor),
      foregroundColor: MaterialStateProperty.all<Color?>(primaryColor),
      overlayColor: MaterialStateProperty.all<Color?>(shadowColor.shade800),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.all<Color?>(primaryColor),
  ),
  dividerColor: Colors.grey,
  textTheme: TextTheme(
    displayLarge: TextStyle(color: Colors.grey[50]),
    displayMedium: TextStyle(color: Colors.grey[50]),
    displaySmall: TextStyle(color: Colors.grey[50]),
    headlineLarge: TextStyle(color: Colors.grey[50]),
    headlineMedium: TextStyle(color: Colors.grey[50]),
    headlineSmall: TextStyle(color: Colors.grey[50]),
    bodyLarge: TextStyle(color: Colors.grey[50]),
    bodyMedium: TextStyle(color: Colors.grey[50]),
    bodySmall: TextStyle(color: Colors.grey[50]),
    titleSmall: TextStyle(color: Colors.grey[50]),
    titleMedium: TextStyle(color: Colors.grey[50]),
    titleLarge: TextStyle(color: Colors.grey[50]),
    labelSmall: TextStyle(color: Colors.grey[50]),
    labelMedium: TextStyle(color: Colors.grey[50]),
    labelLarge: TextStyle(color: Colors.grey[50]),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: primaryColor,
    foregroundColor: backgroundColor,
  ),
);

// CupertinoThemeData cupertinoLight = CupertinoThemeData(
//   brightness: Brightness.light,
//   primaryColor: primaryColor,
//   barBackgroundColor: backgroundColor,
//   scaffoldBackgroundColor: Colors.grey[50],
//   textTheme: CupertinoTextThemeData(
//     primaryColor: Colors.black,
//     actionTextStyle: TextStyle(
//       color: Colors.red,
//       backgroundColor: Colors.amber,
//     ),
//   ),
//   primaryContrastingColor: Colors.white,
// );

// CupertinoThemeData? cupertinoDark = CupertinoThemeData(
//   brightness: Brightness.dark,
//   primaryColor: primaryColor,
//   barBackgroundColor: backgroundColor,
//   scaffoldBackgroundColor: Colors.grey[50],
//   textTheme: CupertinoTextThemeData(
//     primaryColor: Colors.black,
//     actionTextStyle: TextStyle(
//       color: Colors.red,
//       backgroundColor: Colors.amber,
//     ),
//   ),
//   primaryContrastingColor: Colors.white,
// );

