import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';

class MessageUpload extends StatefulWidget {
  const MessageUpload({super.key});

  @override
  State<MessageUpload> createState() => _MessageUploadState();
}

class _MessageUploadState extends State<MessageUpload> {
  static const confirm = true;
  String? _myValue;
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mensajes"),
        centerTitle: true,
      ),
      body: Center(
        child: enableUpload(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        },
        tooltip: "Añadir mensaje",
        child: Icon(Icons.add_card),
      ),
    );
  }
  Widget enableUpload(){
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key:formkey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Descripción",
                  ),
                  validator: ((value) {
                    return value!.isEmpty ? "La descripción es requerida" : null;
                  }),
                  onSaved: (value) {
                    _myValue = value;
                  },
                ),
                SizedBox(
                  height: 35.0,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 10)),
                  onPressed: uploadStatus,
                  child: Text("Añade un nuevo mensaje"),
                  
                )
              ]
              ),
          ),
        ),
      ),
    );
  }

  void uploadStatus() async{
    if(validateAndSave()){
      //Guardar mensaje
      saveToDatabase();
      //Regresar a Home
      Navigator.pop(context);
    }
  }

  void saveToDatabase(){
    var dbTimeKey = DateTime.now();
    var formatDate = DateFormat('MMM d, yyyy');
    var formatTime = DateFormat('EEEE, hh:mm aaa');

    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);

    DatabaseReference ref = FirebaseDatabase.instance.ref();
    var data = {
      "descripcion": _myValue,
      "date": date,
      "time": time
    };
    ref.child("Mensajes").push().set(data);
  }

  bool validateAndSave(){
    final form = formkey.currentState;
    if(form!.validate()){
      form.save();
      return true;
    }else{
      return false;
    }
  }
}