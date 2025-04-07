import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String contact;

  ChatPage({required this.contact});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageControler = TextEditingController();
  List<String> messages = ['adasd', 'adasd', 'adasd', 'adasd', 'adasd', 'adasd', 'adasd', 'adasd', 'adasd', 'adasd', 'adasd', 'adasd', 'adasd', 'fe0f596e3cca4fad8a8c2f4136264b77e253d06b54a14d2fbbf22bd2c4809de00ab2b6a591c9489280e43db8c1919fc33dc219df3012444c940790b49ce0ca33'];
  final ScrollController _scrollController = ScrollController();

  void _sendMessage(String value) {
    String message = value.trim();
    if (message.isNotEmpty) {
      setState(() {
        messages.add(message);
      });
      _messageControler.clear();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    }
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(44.0), 
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 0.3
              )
            ),
          ),
          child: AppBar(
            title: Text(widget.contact),
            backgroundColor: Colors.grey.shade200,
          ),
        )
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset('assets/images/dandan.png', width: 50,height: 50,),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 92, left: 12),
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: Text(messages[index]),
                      )
                    )
                  ],
                );
              },
            )
            ),
            // for (var message in messages)
            //   Row(
            //     children: [
            //       ClipRRect(
            //         borderRadius: BorderRadius.circular(10),
            //         child: Image.asset('assets/images/dandan.png', width: 50,height: 50,),
            //       ),
            //       Text(message)
            //     ],
            //   ),
          ] ,
        )
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade100,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageControler,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                    // contentPadding: EdgeInsets.all(11.0),
                    hintText: 'message...'
                  ),
                  onSubmitted: (value) {
                    _sendMessage(value);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}