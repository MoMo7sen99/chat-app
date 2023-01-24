
import 'package:chatapp/models/message.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/components.dart';
import '../components/const.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);

  static String id = "ChatScreen";

  final _controller = ScrollController();

  CollectionReference messages =
      FirebaseFirestore.instance.collection(KMessagescollection);

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    String? text;

    var email = ModalRoute.of(context)!.settings.arguments;

    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(KCreatedAt,descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData){
          List<Message> messagesList = [];
          for (int i =0 ; i<snapshot.data!.docs.length; i++){
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }


          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    KLogo,
                    color: Colors.white,
                    height: 40,
                    width: 40,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text("Chat"),
                ],
              ),
              automaticallyImplyLeading: false,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _controller ,
                    itemCount: messagesList.length,
                    itemBuilder: (BuildContext context, int index) =>
                       messagesList[index].id==email ?
                       ChatWidget(message: messagesList[index],) :
                       ChatWidgetFriend(message: messagesList[index],),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: buildTextField(
                      controller: controller,
                      onChange: (data) {
                        text = data ;
                      }, onPressed: () {
                    messages.add({
                      KMessage: text,
                      KCreatedAt: DateTime.now(),
                      "id" : email,
                    });
                    controller.clear();
                    _controller.animateTo(0,
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeIn
                    );
                  }),
                ),
              ],
            ),
          );
        }else{
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
