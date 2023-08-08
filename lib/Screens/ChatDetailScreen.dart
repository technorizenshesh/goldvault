import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:goldvault/Constants/GlobalVariable.dart';
import 'package:goldvault/Constants/api_constants.dart';
import 'package:goldvault/Constants/webService.dart';
import 'package:goldvault/Models/GetChatModel.dart';
import 'package:goldvault/Models/InsertChatModel.dart';
import 'package:goldvault/Widgets/CustomSnackBar.dart';
import 'package:goldvault/Widgets/CustomTexts.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:intl/intl.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {

  TextEditingController messageController = TextEditingController();
  bool sendVisibility = false;
  var formattedDate;

  sendMessage() async {
    Map<String, dynamic> data = {
      "sender_id": userId,
      "receiver_id": "123456789",
      "chat_message": messageController.text,
    };
    var res = await Webservices.postData(
        apiUrl: "$baseUrl$insert_chat", body: data, context: context);
    print("status from api ${res}");
    final resdata = InsertChatModel.fromJson(res);
    if (resdata.status == '1') {
      insertChatResult = resdata.result;
      messageController.clear();
      FocusScope.of(context).unfocus();
      showSnackbar(context, resdata.message);
      getChat();
      sendVisibility = !sendVisibility;
      setState(() {});
    } else {
    }
  }

  getChat() async {
    print("hii");
    Map<String, dynamic> data = {
      "receiver_id": "123456789",
      "sender_id": userId

    };
    var res = await Webservices.postData(
        apiUrl: "$baseUrl$get_chat", body: data, context: context);
    print("status from api ${res}");
    final resdata = GetChatModel.fromJson(res);
    if (resdata.status == '1') {
      getChatResult = resdata.result;
      setState(() {});
    } else {
    }
  }


  @override
  void initState() {
    if (getChatResult.isEmpty) {
      getChat();
    }
    tz.initializeTimeZones();
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      // Call your method here
      setup();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Color(0xffefb129),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset('assets/images/ChatScreenLogo.svg'),
            SizedBox(height: 10,),
            SvgPicture.asset('assets/images/CustomerSupport.svg',height: 20,),
            Row(
              children: [
                SvgPicture.asset('assets/images/LocationIconBlack.svg',height: 15,),
                SizedBox(width: width*0.02,),
                SubHeadingText(text: "$formattedDate in Indore, India".tr,fontWeight: FontWeight.w500,fontSize: 13,)
              ],
            )

          ],
        ),
        leading:
        IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          IconButton(
              icon: Icon(Icons.clear),
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              }),
        ], systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Stack(
        children: [
          getChatResult.isEmpty?CircularProgressIndicator():
          Container(
            height: height * 0.78,
            child: Expanded(
              child: ListView.builder(
            reverse: true,
                padding: EdgeInsets.symmetric(horizontal: 20),
                itemCount: getChatResult.length,
                itemBuilder: (BuildContext context, int index) {
                 final bool isMe = userId == getChatResult[index].senderId;
                // final bool isSameUser = prevUserId == message.sender.id;
                // prevUserId = message.sender.id;
                 return _chatBubble(getChatResult[index], isMe);
              },),
            ),
          ),
          _sendMessageArea()
        ],
      ),
    );
  }

  _chatBubble(GetChatResult messageResult, bool isMe) {
    if (isMe) {
      return Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topRight,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Color(0xffefb129),
                // color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15),
                    topRight:Radius.circular(15),bottomLeft: Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Text(
                messageResult.chatMessage,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ), Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                DateFormat('hh:mm a').format(messageResult.date),
              //  "messageResult.date as String",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black45,
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15),
                  topRight:Radius.circular(15),bottomRight: Radius.circular(15),),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Text(
                messageResult.chatMessage,
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
          ), Row(
            children: <Widget>[
              // Container(
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.grey.withOpacity(0.5),
              //         spreadRadius: 2,
              //         blurRadius: 5,
              //       ),
              //     ],
              //   ),
              //   child: CircleAvatar(
              //     radius: 15,
              //     backgroundImage: AssetImage(message.sender.imageUrl),
              //   ),
              // ),
              SizedBox(
                width: 10,
              ),
              Text(
               "messageResult.date as String",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black45,
                ),
              ),
            ],
          )
        ],
      );
    }
  }

  _sendMessageArea() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        height: MediaQuery.of(context).size.height*0.055,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                decoration: InputDecoration.collapsed(
                  hintText: 'Type message'.tr,
                ),
                controller: messageController,
                onChanged: (f) {
                  sendVisibility = true;
                  messageController.text == ""
                      ? sendVisibility = false
                      : sendVisibility = true;
                  setState(() {});
                },
              ),
            ),
            // IconButton(
            //   icon: Icon(Icons.photo),
            //   iconSize: 25,
            //   color: Theme.of(context).primaryColor,
            //   onPressed: () {},
            // ),
            // IconButton(
            //   icon: Icon(Icons.gif_box_outlined),
            //   iconSize: 25,
            //   color: Theme.of(context).primaryColor,
            //   onPressed: () {},
            // ),
            Visibility(
              visible: sendVisibility,
              child: IconButton(
                icon: SvgPicture.asset('assets/images/SendIcon.svg'),
                iconSize: 25,
                color: Color(0xffefb129),
                onPressed: () {
                  sendMessage();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


  Future<void> setup() async {
    var istanbulTimeZone = tz.getLocation('Asia/Kolkata');
    var now = tz.TZDateTime.now(istanbulTimeZone);
    formattedDate = DateFormat('hh:mm a').format(now);
    setState(() {

    });
    print("time is.....$formattedDate");
  }
}
