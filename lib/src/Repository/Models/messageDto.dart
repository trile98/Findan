class MessageDto{
  int messageCode; // 0 - success, 1 - fail
  String? message;
  Map<String, dynamic>? attachedObject;


  MessageDto({required this.messageCode,this.message, this.attachedObject});


}