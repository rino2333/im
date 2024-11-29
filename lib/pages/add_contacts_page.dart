import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;

class AddContactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(44.0),
        child: AppBar(
          title: Text('Add Contacts'),
          backgroundColor: Colors.grey.shade200,
        ),
      ),
      body: Account(),
    );
  }
}

class Account extends StatefulWidget {
  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final TextEditingController _accountControler = TextEditingController();

  void _addContact() async {
    String account = _accountControler.text.trim();
    if (account.isNotEmpty) {
    print(prefs);
      
      try {
        String? token = prefs?.getString('token');
        if (token != null) {
    print(token);

          final response = await http.post(
            Uri.parse('http://47.245.82.251:31104/api/community/friend/friend-add-cancel'),
            headers: {
              'Authorization': token
            },
          );
          print(response);
        }
        
      } catch (e) {
        print(e);
      }
    } else {
    
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0)
              ),
              child: TextField(
                controller: _accountControler,
                decoration: InputDecoration(
                  border: OutlineInputBorder( 
                    borderSide: BorderSide.none,
                  )
                ),
              ),
            ),
          ),
          SizedBox(width: 10,),
          ElevatedButton(
            onPressed: () {
              _addContact();
            }, 
            child: Icon(Icons.add)
          )
        ],
      ),
    );
  }
}