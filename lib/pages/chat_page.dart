import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String contact;

  ChatPage({required this.contact});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageControler = TextEditingController();
  List<String> messages = [];
  final ScrollController _scrollController = ScrollController();

  void _sendMessage(String value) {
    String message = value.trim();
    if (message.isNotEmpty) {
      setState(() {
        messages.add(message);
      });
      _messageControler.clear();
    }
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