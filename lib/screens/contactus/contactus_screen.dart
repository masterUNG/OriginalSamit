import 'package:flutter/material.dart';

class ContactusScreen extends StatefulWidget {
  ContactusScreen({Key key}) : super(key: key);

  @override
  _ContactusScreenState createState() => _ContactusScreenState();
}

class _ContactusScreenState extends State<ContactusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ติดต่อทีมงาน'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('BAAC A-Staff Team contact', style: TextStyle(fontSize: 20),),
          ),
          Padding(
            padding: const EdgeInsets.only(left:20.0, right: 20.0, bottom: 20.0),
            child: Text('As with my other dribble challenge, and generally the way I work, I want to get the basics done first and then refine', style: TextStyle(fontSize: 16),),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('อีเมล์'),
            subtitle: Text('admin@baacstaff.com'),
            trailing: Icon(Icons.send),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.call),
            title: Text('โทรศัพท์'),
            subtitle: Text('02-5879965-01'),
            trailing: Icon(Icons.call_missed_outgoing),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.print),
            title: Text('แฟกซ์'),
            subtitle: Text('02-5879965-01'),
            trailing: Icon(Icons.settings_input_hdmi),
            onTap: (){},
          ),
        ],
      ),
    );
  }
}