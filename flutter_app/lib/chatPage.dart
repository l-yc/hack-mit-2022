import 'package:flutter/material.dart';
import 'package:flutter_app/solana.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:solana/solana.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/chat.dart';
import 'package:flutter_app/profile.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

/*
class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return 
  }
}
*/

class ConversationList extends StatefulWidget {
  String name;
  String messageText;
  String imageUrl;
  String time;
  bool isMessageRead;
  ConversationList(
      {required this.name,
      required this.messageText,
      required this.imageUrl,
      required this.time,
      required this.isMessageRead});
  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        PersistentNavBarNavigator.pushNewScreen(context,
            screen: Scaffold(body: ChatWidget()),
            withNavBar: true,
            pageTransitionAnimation: PageTransitionAnimation.cupertino);
      },
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Image.asset(widget.imageUrl),
                    maxRadius: 30,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.name,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.messageText,
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                                fontWeight: widget.isMessageRead
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              widget.time,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: widget.isMessageRead
                      ? FontWeight.bold
                      : FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatUsers {
  String text;
  String secondaryText;
  String imageURL;
  String time;
  ChatUsers(
      {required this.text,
      required this.secondaryText,
      required this.imageURL,
      required this.time});
}

class ChatPageWidget extends StatefulWidget {
  const ChatPageWidget({super.key});

  @override
  State<ChatPageWidget> createState() => _ChatPageWidgetState();
}

class _ChatPageWidgetState extends State<ChatPageWidget> {
  final Future<Ed25519HDKeyPair> _wallet_address = Solana.loadKeyPair();
  List<ChatUsers> chatUsers = [
    ChatUsers(
        text: "YC",
        secondaryText: "Awesome Picture!",
        imageURL: "images/p1.png",
        time: "Now"),
    ChatUsers(
        text: "Shin",
        secondaryText: "LOL",
        imageURL: "images/p2.png",
        time: "3h"),
    ChatUsers(
        text: "Toya",
        secondaryText: "How is it going?",
        imageURL: "images/p3.png",
        time: "8h"),
    ChatUsers(
        text: "Yongao",
        secondaryText: "Hello :)",
        imageURL: "images/p5.png",
        time: "1d"),
    ChatUsers(
        text: "Joel",
        secondaryText: "I forgot my confirmation oop",
        imageURL: "images/p4.png",
        time: "3d"),
  ];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Ed25519HDKeyPair>(
        future: _wallet_address,
        builder:
            (BuildContext context, AsyncSnapshot<Ed25519HDKeyPair> snapshot) {
          String addr = "initializing...";
          if (snapshot.hasData) {
            addr = snapshot.data?.address ?? "null";
          } else if (snapshot.hasError) {
            addr = "failed to get addr";
          }

          return Scaffold(
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Chat",
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 8, right: 8, top: 2, bottom: 2),
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.green[50],
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.add,
                                  color: Colors.green,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "Add New",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search...",
                        hintStyle: TextStyle(color: Colors.grey.shade600),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey.shade600,
                          size: 20,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding: EdgeInsets.all(8),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                BorderSide(color: Colors.grey.shade100)),
                      ),
                    ),
                  ),
                  ListView.builder(
                    itemCount: chatUsers.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 16),
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ConversationList(
                        name: chatUsers[index].text,
                        messageText: chatUsers[index].secondaryText,
                        imageUrl: chatUsers[index].imageURL,
                        time: chatUsers[index].time,
                        isMessageRead:
                            (index == 0 || index == 3) ? true : false,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
