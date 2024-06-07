DateTime? stringToDate(String? dateString) {
  if (dateString != "" && dateString != null) {
    // Split the string into date and time parts
    List<String> dateTimeParts = dateString.split('T');

    // Parse the date part
    List<String> dateParts = dateTimeParts[0].split('-');
    int year = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int day = int.parse(dateParts[2]);

    // Parse the time part if it exists
    if (dateTimeParts.length > 1) {
      List<String> timeParts = dateTimeParts[1].split(':');
      int hour = int.parse(timeParts[0]);
      int minute = int.parse(timeParts[1]);
      // Split seconds and milliseconds
      List<String> secondsParts = timeParts[2].split('.');
      int second = int.parse(secondsParts[0]);
      int millisecond = int.parse(secondsParts[1]);

      // Create a DateTime object from the parsed values
      DateTime dateTime =
          DateTime(year, month, day, hour, minute, second, millisecond);
      return dateTime;
    }

    // Create a DateTime object from the parsed values if no time part
    DateTime dateTime = DateTime(year, month, day);
    return dateTime;
  }
  return null;
}
