import 'package:chatapp/components/const.dart';


class Message {
  final String message;
  final String id;

  Message(this.message,this.id);

  factory Message.fromJson ( data){

    return Message(data[KMessage],data["id"]);
  }

}