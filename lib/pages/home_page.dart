import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(44.0), 
        child: AppBar(
          title: Text('IM'),
          backgroundColor: Color(0xffeaeaea),
        )),
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

  @override
  Widget build(BuildContext context) {
      return ListView(
        children: [
          for (var contact in contacts) 
            ListTile(
              title: Text(contact),
              leading: Image.asset('assets/images/dandan.png', width: 78, height: 78,),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
              },
            ),
          for (var contact in contacts) 
            Container(
              alignment: Alignment.centerLeft,
              // height: 68,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              color: Color(0xffffffff),
              // color: Color.fromARGB(255, 47, 189, 104),
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
                          )
                        )
                      ),
                      child: Text(contact),
                    ),
                  ),
                ],
              ),
            ),
            // BigCard(contact: contact),
          // Image(image: AssetImage('https://docs.flutter.cn/assets/images/cn/flutter-cn-logo.png')),
          // Image.network('https://docs.flutter.cn/assets/images/cn/flutter-cn-logo.png')
        ],
      );
  }
}