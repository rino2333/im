import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String contact;

  ChatPage({required this.contact});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageControler = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(44.0), 
        child: AppBar(
          title: Text(widget.contact),
          backgroundColor: Colors.grey.shade200,
        )
      ),
      body: ListView(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset('assets/images/dandan.png', width: 50,height: 50,),
              ),
            ],
          ),
        ] 
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade100,
        child: TextField(
          controller: _messageControler,
        ),
      ),
    );
  }
}