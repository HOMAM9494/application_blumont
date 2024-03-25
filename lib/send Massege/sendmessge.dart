import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class SendMassege extends StatefulWidget {
  const SendMassege({super.key});

  @override
  State<SendMassege> createState() => _SendMassegeState();
}

class _SendMassegeState extends State<SendMassege> {

  getToken() async {
    String? mytoken = await FirebaseMessaging.instance.getToken();
    print("=========================================> $mytoken");
    return mytoken;
  }

  myPermissions() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }
  sendMessage(title , bodyMessage)async{
    var headersList = {
      'Accept': '*/*',
      'Content-Type': 'application/json',
      'Authorization': 'key=AAAAVRN5BvY:APA91bF-7-qQ0HE1xwnMks5zi0iDSrJ2gzAcvqXPLAZOHD7-abmZ1sdhs6MhlT3yavrsHgrbohPPiqX8sJGojrIBHIkRB6ouTGyZEOqMRcjzqRHPEpfg3k5mxKtnDEVZNwXAyZ_R6ahP'
    };
    var url = Uri.parse('https://fcm.googleapis.com/fcm/send');

    var body = {
      "to": "/topics/Manger",
      "notification": {
        "title": title,
        "body": bodyMessage,
      }
    };

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);


    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
    }
    else {
      print(res.reasonPhrase);
    }
  }


  @override
  void initState() {
    myPermissions();
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Center(
            child: MaterialButton(
              onPressed: () {
                sendMessage("homam alslamat ", "welcam to applaiction in Blumont");
              },
              child: const Text("send Message"),
            ),
          )
        ],
      ),
    );
  }
}
