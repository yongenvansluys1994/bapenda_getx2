void logInfo(String message) {
  const String yellow = '\x1B[33m';
  const String reset = '\x1B[0m';
  print('$yellow[INFO] $message$reset');
}

void logValue(String message) {
  const String green = '\x1B[32m';
  const String reset = '\x1B[0m';
  print('$green[VALUE] $message$reset');
}

void logWarning(String message) {
  const String magenta = '\x1B[35m';
  const String reset = '\x1B[0m';
  print('$magenta[WARNING] $message$reset');
}

void logError(String message) {
  const String red = '\x1B[31m';
  const String reset = '\x1B[0m';
  print('$red[ERROR] $message$reset');
}
