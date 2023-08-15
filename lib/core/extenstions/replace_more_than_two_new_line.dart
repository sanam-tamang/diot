extension DateTimeExtension on String {
  String replaceNewLineUpTo2() {
    final data = this;
    return data.replaceAll(RegExp('\n\n+'), '\n\n');
  }
}
