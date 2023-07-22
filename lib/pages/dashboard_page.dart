import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grocery_flutter/pages/profile_page.dart';

import '../api/api_service.dart';
import '../models/chat_model.dart';
 
import '../widgets/widget_chat.dart';
import '/pages/favorite_page.dart';

import 'cart_page.dart';
import 'home_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  final List<Widget> widgetList = const [
    HomePage(),
    CartPage(),
    FavoritePage(),
    ProfilePage()
  ];

  int index = 0;
  bool isChatVisible = false;
  bool isButtonVisible = true;
  Offset _offset = const Offset(350, 750);
  bool _isTyping = false;

  late TextEditingController textEditingController;
  late ScrollController _listScrollController;
  late FocusNode focusNode;
  @override
  void initState() {
    _listScrollController = ScrollController();
    textEditingController = TextEditingController();
    focusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  List<ChatModel> chatList = [ChatModel(msg: "bạn muốn tìm gì", chatIndex: 0)];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.shifting,
        currentIndex: index,
        onTap: (i) {
          setState(() {
            index = i;
            isChatVisible = false;
            isButtonVisible = true;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket), label: "Store"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Favorite"),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle), label: "My account"),
        ],
      ),
      body: Stack(
        children: [
          widgetList[index],
          if (isChatVisible)
            Positioned(
              bottom: 120.0,
              right: 16.0,
              child: Container(
                width: 300.0,
                height: 400.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Expanded(
                            child: Text(
                              'Hỏi Đáp',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              InkWell(
                                focusColor: Colors.grey,
                                onTap: () {
                                  setState(() {
                                    chatList = [
                                      ChatModel(
                                          msg: "bạn muốn tìm gì", chatIndex: 0)
                                    ];
                                  });
                                },
                                child: Icon(Icons.refresh),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  setState(() {
                                    isChatVisible = false;
                                    isButtonVisible = true;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Container(
                      color: Colors.grey.shade300,
                      child: ListView.builder(
                          controller: _listScrollController,
                          addAutomaticKeepAlives: false,
                          addRepaintBoundaries: false,
                          addSemanticIndexes: false,
                          itemCount: chatList.length,
                          itemBuilder: (c, i) {
                            return ChatWidget(
                                msg: chatList[i].msg,
                                chatIndex: chatList[i].chatIndex);
                          }),
                    )),
                    if (_isTyping)
                      const SpinKitThreeBounce(
                        color: Colors.blue,
                        size: 18,
                      ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                focusNode: focusNode,
                                keyboardType: TextInputType.multiline,
                                controller: textEditingController,
                                minLines: 1,
                                maxLines: 3,
                                onChanged: (value) {
                                  setState(() {
                                    _isTyping = value.isNotEmpty;
                                  });
                                },
                                autocorrect: true,
                                enabled: true,
                                decoration: InputDecoration(
                                  hintText: 'Nhập tin nhắn',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide:
                                        BorderSide.none, // Tắt dấu gạch dưới
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  contentPadding: const EdgeInsets.all(16.0),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                print(await ApiService.getNameProducts());
                                ChatModel modelChat =
                                    await ApiService.sendMessage(
                                        message:
                                            textEditingController.text.trim());
                                if (textEditingController.text.isNotEmpty) {
                                  setState(() {
                                    chatList.add(ChatModel(
                                      msg: textEditingController.text,
                                      chatIndex: 1,
                                    ));
                                    textEditingController.clear();
                                    _isTyping = false;
                                    chatList.add(modelChat);
                                    scrollListToEND();
                                  });
                                }
                              },
                              icon: const Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (isButtonVisible)
            Positioned(
              left: _offset.dx,
              top: _offset.dy,
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    _offset += details.delta;
                    _offset = Offset(
                      _offset.dx
                          .clamp(0, MediaQuery.of(context).size.width - 56),
                      _offset.dy
                          .clamp(0, MediaQuery.of(context).size.height - 100),
                    );
                  });
                },
                onPanEnd: (details) {},
                child: FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      isChatVisible =
                          true; // Hiển thị khung chat khi nhấn nút float button
                      isButtonVisible =
                          false; // Ẩn nút float button khi hiển thị khung chat
                    });
                  },
                  child: Image.asset("assets/bot.png",fit: BoxFit.cover, width: 30,height: 30,),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void scrollListToEND() {
    // _listScrollController.jumpTo(_listScrollController.position.maxScrollExtent);
    _listScrollController.animateTo(
        _listScrollController.position.maxScrollExtent + 60,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOut);
  }

  ChatModel totext() {
    return ChatModel(msg: "tien", chatIndex: 0);
  }

  Future<void> sendMessageFCT() async {}
}
