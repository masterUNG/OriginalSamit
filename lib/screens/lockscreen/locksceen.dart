import 'package:ASmartApp/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:ASmartApp/screens/lockscreen/Numpad.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart'; // ไว้เรียกใช้ส่วนการ lock screen เป็นแนวตั้ง

class LockScreen extends StatefulWidget {

  LockScreen({Key key}) : super(key: key);

  @override
  _LockScreenState createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {

  int length = 6;

  onChange(String number){
    if(number.length == length){

      print(number);
      if(number == '123456'){
        _setLockScreenSubmit();
      }else{
        Utility.getInstance().showAlertDialog(context, 'ขออภัย', 'รหัสผ่านไม่ถูกต้อง กรุณาใส่รหัสผ่านอีกครั้ง', 'ตกลง');
      }
    }
  }

  void _setLockScreenSubmit() async {

    // สร้างตัวเก็บข้อมูลแบบ SharedPreferences
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('storeStep', 3);
    Navigator.pushReplacementNamed(context, '/dashboard');

  }

  @override
  Widget build(BuildContext context) {

    // ตั้งค่าล็อก Screen เป็นแนวตั้ง
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/astaff_logo.png',
              width: 80,
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                'กรุณาใส่รหัสผ่าน',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400, color: Colors.black),
              ),
            ),
            Numpad(length: length, onChange: onChange,)
          ],
        ),
      ),
    );
  }
}