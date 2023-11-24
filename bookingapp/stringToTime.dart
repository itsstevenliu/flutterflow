
DateTime? stringtoTime(
  String? hourArg,
  DateTime? dateArg,
) {
  /// MODIFY CODE ONLY BELOW THIS LINE

  // output the combination of date from dateArg and hourArg (HH:mm format)
  if (hourArg == null || dateArg == null) {
    return null;
  }
  final hourMin = hourArg.split(':');
  final hour = int.tryParse(hourMin[0]) ?? 0;
  final minute = int.tryParse(hourMin[1]) ?? 0;
  return DateTime(dateArg.year, dateArg.month, dateArg.day, hour, minute);

  /// MODIFY CODE ONLY ABOVE THIS LINE
}
