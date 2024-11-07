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
      body: Row(
        children: [
          SafeArea(
            child: NavigationRail(
              extended: false,
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.settings),
                  label: Text('张三'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.message),
                  label: Text('李四'),
                ),
              ], 
              selectedIndex: selectedIndex,
              onDestinationSelected: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
            ),
          ),
          // SizedBox(
          //   width: 260,
          //   child: ContactsPage(),
          // ),
          Container(
            width: 260,
            color: Color(0xFFdddddd), // 设置背景色
            child: ContactsPage()
          ),

          Expanded(
            child: Text('123')
          )
        ],
      ),
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
          // for (var contact in contacts) 
          //   ListTile(
          //     title: Text(contact),
          //     leading: Icon(Icons.person),
          //     trailing: Icon(Icons.chevron_right),
          //     onTap: () {
          //     },
          //   ),
          for (var contact in contacts) 
            Container(
              alignment: Alignment.centerLeft,
              width: 260,
              height: 68,
              padding: const EdgeInsets.all(12),
              // color: Color(0xffdddddd),
              // color: Color.fromARGB(255, 47, 189, 104),
              child: Text(contact),
            ),
            // BigCard(contact: contact),
          // Image(image: AssetImage('https://docs.flutter.cn/assets/images/cn/flutter-cn-logo.png')),
          // Image.network('https://docs.flutter.cn/assets/images/cn/flutter-cn-logo.png')
        ],
      );
  }
}