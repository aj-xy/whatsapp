import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Chatpage extends StatefulWidget {
  const Chatpage({super.key});

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController chatController = TextEditingController();
   CollectionReference chats = FirebaseFirestore.instance.collection('chats');
   Future<void> addchat() {
    return chats
        .add({
          'Chat': chatController.text,
        })
        .then((value) => print("Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(20, 40, 100, 1),
      appBar: AppBar(
        backgroundColor: Colors.grey.withOpacity(0.4),
        foregroundColor: Colors.white,
        actions: [
          Icon(
            Icons.videocam_outlined,
            color: Colors.white,
            size: 40,
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.phone_outlined,
            color: Colors.white,
            size: 30,
          ),
          SizedBox(
            width: 20,
          )
        ],
        centerTitle: true,
        title: SizedBox(
            child: Row(
          children: [
            Icon(Icons.person),
            SizedBox(
              width: 10,
            ),
            Text("Sam")
          ],
        )),
      ),
      
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(height: MediaQuery.of(context).size.height-130,
                child: Column(mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                            
                Row(
                  children: [
                    Container(height: 50,width: 343,
                      child: TextField(controller: chatController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(gapPadding: 20),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white, width: 3),
                                borderRadius: BorderRadius.circular(20)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white, width: 3),
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      
                    ),IconButton(style: IconButton.styleFrom(backgroundColor: Colors.green,),onPressed: () {
                      addchat();
                    }, icon: Icon(Icons.send_rounded,color: Colors.white,))
                  ],
                )
                        ],
                      ),
              ),
            )),
      ),
    );
  }
}
