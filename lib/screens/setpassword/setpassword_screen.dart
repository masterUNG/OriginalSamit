import 'package:ASmartApp/screens/components/passwordwidget.dart';
import 'package:ASmartApp/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetPasswordScreen extends StatefulWidget {
  SetPasswordScreen ({Key key}) : super(key: key);

  @override
  _SetPasswordScreenState createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen > {

  final formKey = GlobalKey<FormState>();

  String _password;
  String _passwordConfirmed;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text("กำหนดรหัสผ่านเพื่อใช้งาน")),
      ),
      // resizeToAvoidBottomPadding: false,
      body: GestureDetector(
         onTap: (){
           FocusScope.of(context).unfocus();
         },
         
         child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
              key: formKey,
              child: ListView(
              children: [
                PasswordField(
                  // fieldKey: _passwordFieldKey,
                  helperText: 'ไม่เกิน 6 หลัก',
                  labelText: 'กำหนดรหัสผ่าน',
                  validator: (value){
                    if(value.isEmpty){
                      return 'กรอกรหัสผ่านก่อน';
                    }else if(value.length != 6){
                      return 'กรุณาป้อนรหัสผ่านด้วยเลข 6 หลัก';
                    }else{
                      return null;
                    }
                  },
                  onFieldSubmitted: (String value) {
                    setState(() {
                      this._password = value;
                    });
                  },
                  onSaved: (value){
                    _password = value.trim();
                  },
                ),
                SizedBox(height: 8.0),
                PasswordField(
                  // fieldKey: _passwordConfirmedFieldKey,
                  helperText: 'ไม่เกิน 6 หลัก',
                  labelText: 'ยืนยันรหัสผ่านอีกครั้ง *',
                  validator: (value){
                    if(value.isEmpty){
                      return 'กรอกยืนยันรหัสผ่านก่อน';
                    }else if(value.length != 6){
                      return 'กรุณาป้อนยืนยันรหัสผ่านด้วยเลข 6 หลัก';
                    }else{
                      return null;
                    }
                  },
                  onFieldSubmitted: (String value) {
                    setState(() {
                      this._passwordConfirmed = value;
                    });
                  },
                  onSaved: (value){
                    _passwordConfirmed = value.trim();
                  },
                ),
                SizedBox(height: 24.0),
                RaisedButton(
                  onPressed: (){
                    if(formKey.currentState.validate()){
                      formKey.currentState.save();
                      if(_password != _passwordConfirmed){
                        Utility.getInstance().showAlertDialog(context, 'มีข้อผิดพลาด', 'ยืนยันรหัสทั้ง 2 ช่องไม่ตรงกัน','ตกลง');
                      }else{
                        _setPasswordSubmit(context);
                      }
                    }

                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'บันทึกข้อมูล', 
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  color: Colors.green,
                )
              ],
            ),
          ),
        ),
         
       ),
    );
  }

   // Set Password
  void _setPasswordSubmit(BuildContext context) async {
      // สร้างตัวเก็บข้อมูลแบบ SharedPreferences
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setInt('storeStep', 3);
      // BuildContext context;
      Navigator.pushReplacementNamed(context, '/dashboard');
  }
  
}