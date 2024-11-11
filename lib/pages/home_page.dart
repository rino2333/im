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

  @override
  Widget build(BuildContext context) {
      return ListView(
        children: [
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