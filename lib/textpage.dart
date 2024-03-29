import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Chatpage extends StatefulWidget {
  String username;
  Chatpage({super.key, required this.username});

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
          'User': widget.username,
          'Timestap': DateTime.now()
        })
        .then((value) => print("Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey.withOpacity(0.4),
        foregroundColor: Colors.blue,
        actions: [
          Icon(
            Icons.videocam_outlined,
            color: Colors.blue,
            size: 40,
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.phone_outlined,
            color: Colors.blue,
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
            Text(widget.username)
          ],
        )),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 130,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('chats')
                        .orderBy('Timestap', descending: false)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      return SizedBox(
                        height: MediaQuery.of(context).size.height - 200,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      mainAxisAlignment:
                                          snapshot.data?.docs[index]['User'] ==
                                                  widget.username
                                              ? MainAxisAlignment.end
                                              : MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          constraints: BoxConstraints(
                                              minWidth: 100, maxWidth: 200),
                                          margin:
                                              EdgeInsets.symmetric(vertical: 8),
                                          decoration: BoxDecoration(color: snapshot.data?.docs[index]['User'] ==
                                                  widget.username
                                              ? Colors.grey.withOpacity(0.4)
                                              : Color(0xFF2196F3).withOpacity(0.6),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                width: 3,
                                                color: Colors.white,
                                                style: BorderStyle.solid),
                                          ),
                                          padding: EdgeInsets.all(5),
                                          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Row(mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      snapshot.data?.docs[index]
                                                          ['User'],
                                                      style: TextStyle(
                                                        color: const Color.fromRGBO(255, 221, 226, 1),
                                                      )),
                                                ],
                                              ),
                                              Text(
                                                snapshot.data?.docs[index]
                                                    ['Chat'],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17),
                                              ),
                                              Row(mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    '${DateFormat('kk:mm').format(snapshot.data?.docs[index]['Timestap'].toDate())}',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ]),
                      );
                    }),
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 343,
                      child: TextField(
                        controller: chatController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(gapPadding: 20),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 3),
                                borderRadius: BorderRadius.circular(20)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 3),
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                    IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () {
                          addchat();
                        },
                        icon: Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                        ))
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
