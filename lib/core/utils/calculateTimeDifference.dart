import 'package:get/get.dart';

String calculateTimeDifference(String ? createdAt) {

  if(createdAt==""){
    return "";
  }
  if(createdAt != null){
    DateTime createdAtDateTime = DateTime.parse(createdAt);

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
      result = '${minutesDifference}${"months_ago".tr}';
    } else if (hoursDifference < 24) {
      result = '${hoursDifference}${"hours_ago".tr}';
    } else if (daysDifference < 7) {
      result = '${daysDifference}${"days_ago".tr}';
    } else {
      result = '${weeksDifference}${"weeks_ago".tr}'  ;
    }

    return result;

  }else{
    return "";
  }


}
