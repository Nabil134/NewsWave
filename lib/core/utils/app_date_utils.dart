class AppDateUtils{
  AppDateUtils._();
  /*formatRelativeDate start here*/
static String formatRelativeDate(String? dateStr){
  if(dateStr==null || dateStr.isEmpty){
    return "Unknown date";
  }
try{
    final date= DateTime.parse(dateStr).toLocal();
    final now=DateTime.now();
    final diff=now.difference(date);
    if(diff.isNegative || diff.inMinutes<1){
      return "Just now";
    }
    if(diff.inMinutes<60){
      final minutes=diff.inMinutes;
      return minutes==1?"1 min ago":"$minutes min ago";
    }
    if(diff.inHours<24){
      final hours=diff.inHours;
      return hours==1?"1 hour ago":"$hours hours ago";
    }
    final days= diff.inDays;
    return days==1?"1 day ago":"$days days ago";
}
 catch(e){
    return "Unknown date";
 }
}
/*formatRelativeDate end here*/
}