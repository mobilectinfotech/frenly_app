String calculateTimeDifference(String createdAt) {
  DateTime createdAtDateTime = DateTime.parse(createdAt);

  // Get current datetime
  DateTime currentDateTime = DateTime.now();

  // Calculate time difference
  Duration timeDifference = currentDateTime.difference(createdAtDateTime);

  // Extract time difference in minutes, hours, days, and weeks
  int minutesDifference = timeDifference.inMinutes;
  int hoursDifference = timeDifference.inHours;
  int daysDifference = timeDifference.inDays;
  int weeksDifference = daysDifference ~/ 7;

  // Construct the result string based on the conditions
  String result = '';
  if (minutesDifference < 60) {
    result = '${minutesDifference}m ago';
  } else if (hoursDifference < 24) {
    result = '${hoursDifference}h ago';
  } else if (daysDifference < 7) {
    result = '${daysDifference}d ago';
  } else {
    result = '${weeksDifference}w ago'  ;
  }

  return result;
}
