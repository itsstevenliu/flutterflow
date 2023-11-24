
List<DateTime>? getAvailabileSlots(
  List<DateTime> bookings,
  DateTime dateArg,
  List<AvailabilityStruct> availability,
) {
  /// MODIFY CODE ONLY BELOW THIS LINE

  // Hourly block between StartTime & EndTime where DateArg= Availability's DayofWeek exclude Bookings
// First, we need to filter the availability list to only include the DayOfWeekWithTimeStruct objects that match the day of the week of the dateArg.
  final matchingAvailability = availability
      .where((a) =>
          a.dayofWeek.toLowerCase() ==
          DateFormat('EEEE').format(dateArg).toLowerCase())
      .toList();

// Next, we need to create a list of DateTime objects representing the half-hourly blocks between the start and end times of each matching DayOfWeekWithTimeStruct object.
  final availableSlots = <DateTime>[];
  for (final a in matchingAvailability) {
    if (a.hasStartTime() && a.hasEndTime()) {
      final startHour = a.startTime!.hour;
      final endHour = a.endTime!.hour;
      final startMinute = a.startTime!.minute;
      final endMinute = a.endTime!.minute;

      for (var hour = startHour; hour <= endHour; hour++) {
        for (var minute = 0; minute < 60; minute += 30) {
          if (hour == startHour && minute < startMinute) {
            continue; // Skip this half-hour block before the start time.
          }

          if (hour == endHour && minute >= endMinute) {
            break; // Exit the minute loop when reaching or exceeding the end time.
          }

          availableSlots.add(
              DateTime(dateArg.year, dateArg.month, dateArg.day, hour, minute));
        }
      }
    }
  }

  // Finally, we need to filter out any DateTime objects that match the bookings list.
  final availableSlotsFiltered = availableSlots
      .where((slot) => !bookings.any((booking) =>
          booking.hour == slot.hour &&
          booking.minute == slot.minute &&
          booking.day == slot.day &&
          booking.month == slot.month &&
          booking.year == slot.year))
      .toList();

  DateTime now = DateTime.now();

  return availableSlotsFiltered.where((slot) => slot.isAfter(now)).toList();

  /// MODIFY CODE ONLY ABOVE THIS LINE
}
