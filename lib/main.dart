import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Myapp());
  }
}


class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(20, 40, 100, 1),
      body: Center(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 20,
              ),
              TextField(style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: "Username",
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(gapPadding: 20),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 3),
                        borderRadius: BorderRadius.circular(20)),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 3),
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(height: 30,),
              ElevatedButton(onPressed: () {
                
              }, child: Text("Login",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))
            ],
          ),
        )),
      ),
    );
  }
}
