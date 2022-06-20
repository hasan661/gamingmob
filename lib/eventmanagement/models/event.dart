class Events {
  String eventUserID;
  String eventID;
  String eventName;
  // int eventPrice;
  
 
  String cityName;
  String address;

  String organizerEmail;
  
  String eventImageUrl;
  String eventDescription;
  List<RegisteredUsers> usersRegistered;
  String eventDate;
  String eventTime;

  Events({
    required this.address,
    required this.eventID,
    required this.eventImageUrl,
    required this.cityName,
    required this.eventDescription,
    required this.usersRegistered,
    required this.eventDate,
    required this.eventTime,
    required this.eventUserID,
    required this.organizerEmail,
    required this.eventName
   
  });

  
}
class RegisteredUsers{
  String userID;
  String userName;


  RegisteredUsers({required this.userID, required this.userName});



    
}