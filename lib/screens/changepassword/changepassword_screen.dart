import 'package:ASmartApp/screens/components/passwordwidget.dart';
import 'package:ASmartApp/utils/utility.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({Key key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  final formKey = GlobalKey<FormState>();

  String _password;
  String _passwordConfirmed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เปลี่ยนรหัสผ่าน'),
      ),
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
                  labelText: 'รหัสผ่านใหม่ *',
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
                  labelText: 'ยืนยันรหัสผ่านใหม่อีกครั้ง *',
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
                      // _setPasswordSubmit(context);
                      print(_password);
                      print(_passwordConfirmed);
                      if(_password != _passwordConfirmed){
                        Utility.getInstance().showAlertDialog(context, 'มีข้อผิดพลาด', 'ยืนยันรหัสทั้ง 2 ช่องไม่ตรงกัน ลองใหม่');
                      }else{
                        Utility.getInstance().showAlertDialog(context, 'สำเร็จ', 'เปลี่ยนรหัสใหม่แล้ว กรุณาเข้าระบบอีกครั้ง');
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
}