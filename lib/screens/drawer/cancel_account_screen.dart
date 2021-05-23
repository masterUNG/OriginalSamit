import 'package:flutter/material.dart';

class CancelAccount extends StatefulWidget {
  CancelAccount({Key key}) : super(key: key);

  @override
  _CancelAccountState createState() => _CancelAccountState();
}

class _CancelAccountState extends State<CancelAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ยกเลิกการลงทะเบียน'),
      ),
       body: Center(
         child: Text('เนื้อหาหน้ายกเลิกการลงทะเบียน'),
       ),
    );
  }
}