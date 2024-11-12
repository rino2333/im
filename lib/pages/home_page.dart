import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(44.0), 
        child: AppBar(
          title: Text('IM'),
          backgroundColor: Color(0xffeaeaea),
        )
      ),
      body: ContactsPage(),
    );
  }
}

class ContactsPage extends StatefulWidget {

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  var contacts = ['Elon Musk', 'Donald John Trump', 'Tim Cook'];
  // final _channel = WebSocketChannel.connect(
  //   Uri.parse('wss://echo.websocket.events')
  // );
  var channel;
  @override
  void initState() {
    super.initState();
    _connect();
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }



  Future _connect() async {
    try {
      String? token = await getToken();
      if (token != null) {
        final response = await http.post(
          Uri.parse('http://47.245.82.251:31104/api/community/chat/connect'),
          headers: {
            'Authorization': token
          }
        );
        print('${response.body}');
        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          if (responseData['code'] == 0) {
            print('Received: ${responseData['data']}');
            channel = WebSocketChannel.connect(
              Uri.parse(responseData['data']),
            );
            channel.stream.listen(
              (message) {
                print('Received: $message');
              },
               onDone: () {
                print('onDone: ');
              },
              onError: (error) {
                // 处理连接错误
                print('Error: $error');
              },
            );
            channel.sink.add('Hello, WebSocket!');
            final response2 = await http.post(
              Uri.parse('http://47.245.82.251:31104/api/community/chat/connected'),
              headers: {
                'Authorization': token
              }
            );
            print('${response2.body}');
          } else {
          }
        } else {
        }
      }
    } catch (e) {
      print('$e');
    }
  }

  @override
  Widget build(BuildContext context) {
      return ListView(
        children: [
          StreamBuilder(
            stream: channel?.stream,
            builder: (context, snapshot) {
              return Text(snapshot.hasData ? '${snapshot.data}' : '');
            },
          ),
          for (var contact in contacts) 
            // ListTile(
            //   leading: ClipRRect(
            //     borderRadius: BorderRadius.circular(10),
            //     child: Image.asset('assets/images/dandan.png', width: 50, height: 50,),
            //   ),
            //   title: Text(contact, style: const TextStyle(fontWeight: FontWeight.bold),),
            //   subtitle: Text('Some other info', style: const TextStyle(fontSize: 12),),
            // ),
            Container(
              height: 72,
              padding: const EdgeInsets.only(left: 12,),
              color: Color(0xffffffff),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset('assets/images/dandan.png', width: 50, height: 50,),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 0.3,
                          ),
                        )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            contact, 
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 6,),
                          Text(
                            'Some other info',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      );
  }
}