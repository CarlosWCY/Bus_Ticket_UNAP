import 'package:bt_unap/views/messages/messages.dart';
import 'package:bt_unap/views/messages/messages_upload_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  List<Message> messageList = [];

  @override
  void initState() {
    super.initState();

    doSomeStaff();
    // DatabaseReference messageRef = FirebaseDatabase.instance.ref().child("Mensajes");
    // messageRef.once().then((event) {
    //   final snap = event.snapshot;
    //   print("snap = $snap");
    //   var keys = snap.value.key ? snap.value.key : [];
    // var data = snap.value;
    // messageList.clear();
    // for(var individualKey in keys){
    //   Message messages = Message(
    //     data[individualKey]['descripcion'],
    //     data[individualKey]['date'],
    //     data[individualKey]['time']
    //   );
    //   messageList.add(messages);
    // }
    // setState(() {
    //   print('Length: $messageList.length');
    // });

    // },);
  }

  void doSomeStaff() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("Mensajes");

// Query query = ref.orderByChild("age").startAt(18).endAt(30);

    DataSnapshot event = await ref.get();
    print("evemt ... $event");
    final message = event.children;

    message.forEach((element) {
      var temp = element.value.toString();
      print("element = $temp");
    });

    print("message ... $message");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.indigo,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MessageUpload();
                }));
              },
              icon: const Icon(Icons.add_comment),
              iconSize: 40,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
