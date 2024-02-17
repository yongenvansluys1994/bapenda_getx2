class Validators {
  ///Valid email
  static bool email(String email) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  ///Valid password
  // static bool password(String password) =>
  //     RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
  //         .hasMatch(password);

  static bool password(String password) =>
      password.replaceAll(" ", "").length >= 3;

  ///Valid name
  static bool name(String name) => name.replaceAll(" ", "").length >= 3;

  ///Valid name
  static bool phone(String name) => name.replaceAll(" ", "").length >= 8;

  static bool ktp(String name) => name.replaceAll(" ", "").length >= 16;
  static bool npwp(String name) => name.replaceAll(" ", "").length >= 20;
  static bool notEmpty(String name) => name.replaceAll(" ", "").isNotEmpty;
}
