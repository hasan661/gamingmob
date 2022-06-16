class Events{
  String eventUserID;
  String eventID;
  String eventName;
  int eventPrice;
  String streetNo;
  String streetName;
  String cityName;
  String countryName;
  
  String eventImageUrl;
  String eventDescription;
  List<Map<String, String>> usersRegistered;
  String eventDate;
  String eventTime;


  Events({required this.eventID, required this.eventImageUrl, required this.cityName, required this.countryName, required this.streetName, required this.streetNo, required this.eventName, required this.eventPrice, required this.eventDescription, required this.usersRegistered, required this.eventDate, required this.eventTime, required this.eventUserID});
  
}
