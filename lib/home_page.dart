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
          Expanded(
            child: ConstractPage()
          )
        ],
      ),
    );
  }
}

class ConstractPage extends StatefulWidget {

  @override
  State<ConstractPage> createState() => _ConstractPageState();
}

class _ConstractPageState extends State<ConstractPage> {
  var contacts = ['Elon Musk', 'Donald John Trump', 'Tim Cook'];

  @override
  Widget build(BuildContext context) {
      return ListView(
        children: [
          for (var contact in contacts) 
            ListTile(
              title: Text(contact),
              leading: Icon(Icons.person),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
              },
            ),
          for (var contact in contacts) 
            Container(
              alignment: Alignment.centerLeft,
              width: 260,
              height: 68,
              padding: const EdgeInsets.all(12),
              // color: Color(0xffdddddd),
              color: Color(0xFFF6F6F6),
              child: Text(contact),
            ),
            // BigCard(contact: contact),
          // Image(image: AssetImage('https://docs.flutter.cn/assets/images/cn/flutter-cn-logo.png')),
          // Image.network('https://docs.flutter.cn/assets/images/cn/flutter-cn-logo.png')
        ],
      );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.contact,
  });

  final String contact;

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    return Card(
      // color: ColorScheme.fromSeed(seedColor: Colors.red),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(contact),
      ),
    );
  }
}