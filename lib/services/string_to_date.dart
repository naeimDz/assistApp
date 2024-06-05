DateTime? stringToDate(String? dateString) {
  if (dateString != "" && dateString != null) {
    // Split the string into year, month, and day
    List<String> dateParts = dateString.split("-");
    int year = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int day = int.parse(dateParts[2]);

// Create a DateTime object from the parsed values
    DateTime dateTime = DateTime(year, month, day);
    return dateTime;
  }
  return null;
}
