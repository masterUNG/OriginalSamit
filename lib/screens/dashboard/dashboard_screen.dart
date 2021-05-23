import 'package:ASmartApp/screens/bottomnav/benefit_screen.dart';
import 'package:ASmartApp/screens/bottomnav/checkin_screen.dart';
import 'package:ASmartApp/screens/bottomnav/employee_screen.dart';
import 'package:ASmartApp/screens/bottomnav/fundloan_screen.dart';
import 'package:ASmartApp/screens/bottomnav/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  // เรียกใช้ตัวแปร SharedPrefference
  SharedPreferences sharedPreferences;

  // สร้างตัวแปรไว้รับข้อมูลจาก SharedPreferences
  String fullnameAccount, empIDAccount, _avatar;

  // สร้างฟังก์ชันไว้ดึงข้อมูลตัวแปรแบบ sharedPreferences
  readEmployee() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      empIDAccount = sharedPreferences.getString('storeEmpID');
      fullnameAccount = sharedPreferences.getString('storePrename') + 
                      sharedPreferences.getString('storeFirstname') + " " +
                      sharedPreferences.getString('storeLastname');
      _avatar = sharedPreferences.getString('storeAvatar');
    });
  }

  // ฟังก์ชันออกจากระบบ
  signOut() async{
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('storeStep', 4);
    Navigator.pushReplacementNamed(context, '/lockscreen');
  }

  // สถานะเมื่อหน้าจอโดนโหลดมาครั้งแรก
  @override
  void initState() { 
    super.initState();
    readEmployee();
    _actionWidget = _homeActionBar();
  }

  // สร้างตัวแบบ list เก็บรายการหน้าของ tab bottom
  int _currentIndex = 0;
  String _title = 'หน้าหลัก';
  Widget _actionWidget;

  final List<Widget> _children = [
    HomeScreen(),
    BenefitScreen(),
    FundLoanScreen(),
    CheckinScreen(),
    EmployeeScreen()
  ];

  // สร้าง Widget action สำหรับไว้แยกแสดงผลบน Appbar
  Widget _homeActionBar(){
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, '/scan');
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Row(
          children: [
            Icon(Icons.photo_camera),
            Text(' SCAN')
          ],
        ),
      ),
    );
  }

  Widget _checkInActionBar(){
    return FlatButton(
      onPressed: (){},
      child: Row(
        children: [
          Icon(Icons.timelapse, color: Colors.white,),
          Text(
            ' ลงเวลาทำงาน', 
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  // เขียนเงื่อนไขสลับการเปลี่ยน tab
  void onTabTapped(int index){
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0:
          _title = 'หน้าหลัก';
          _actionWidget = _homeActionBar();
          break;
        case 1:
          _title = 'สวัสดิการ';
          _actionWidget = Container();
          break;
        case 2:
          _title = 'กองทุนกู้ยืมเพื่อ...';
          _actionWidget = Container();
          break;
        case 3:
          _title = 'ลงเวลาทำงาน';
          _actionWidget = _checkInActionBar();
          break;
        case 4:
          _title = 'ข้อมูลของฉัน';
          _actionWidget = Container();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text('$_title'),
        actions: [
          _actionWidget
        ],
      ),
      // ส่วนของเมนูด้านข้าง
      drawer: SafeArea(
        child: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                currentAccountPicture: GestureDetector(
                  onTap: () { },
                  child:  _avatar != null ? CircleAvatar(
                    backgroundImage: NetworkImage('$_avatar')
                    // backgroundImage: AssetImage('assets/images/avatar.jpg')
                  ) : CircularProgressIndicator(),
                ),
                accountName: Text('$fullnameAccount'), 
                accountEmail: Text('$empIDAccount'),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/sidecover.jpg'),
                    fit: BoxFit.fill
                  )
                ),
              ),
              ListTile(
                leading: Icon(Icons.new_releases),
                title: Text('ข้อมูลข่าวสาร ธกส.'),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/baacnews');
                },
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('ข้อมูลพนักงาน '),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.branding_watermark),
                title: Text('สวัสดิการ'),
                onTap: (){ 
                  Navigator.pop(context);
                },
              ),
               ListTile(
                leading: Icon(Icons.data_usage),
                title: Text('กองทุนกู้ยืมเพื่อสวัสดิการ'),
                onTap: (){ 
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.pin_drop),
                title: Text('พื้นที่ให้บริการ'),
                onTap: (){ 
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/servicemap');
                },
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('ถ่ายภาพและอัพโหลด'),
                onTap: (){ 
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/camera_and_upload');
                },
              ),
              ListTile(
                leading: Icon(Icons.timelapse),
                title: Text('ดูข้อมูลประวัติการลงเวลา'),
                onTap: (){ 
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/showtimedetail');
                },
              ),
              Divider(color: Colors.green[200],),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('ออกจากระบบ'),
                onTap: (){
                  signOut();
                },
              ),
              ListTile(
                leading: Icon(Icons.cancel),
                title: Text('ยกเลิกการลงทะเบียน'),
                onTap: (){ 
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/cancelaccount');
                },
              ),
            ],
          ),

        )
      ),
      // ส่วนเนื้อหา
      body: _children[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
                gap: 4,
                activeColor: Colors.white,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                duration: Duration(milliseconds: 300),
                tabBackgroundColor: Colors.green[800],
                color: Colors.teal,
                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: 'หน้าหลัก',
                  ),
                  GButton(
                    icon: Icons.enhanced_encryption,
                    text: 'สวัสดิการ',
                  ),
                  GButton(
                    icon: Icons.account_balance,
                    text: 'กองทุน',
                  ),
                  GButton(
                    icon: Icons.access_time,
                    text: 'ลงเวลา',
                  ),
                  GButton(
                    icon: Icons.person,
                    text: 'ฉัน',
                  ),
                ],
                selectedIndex: _currentIndex,
                onTabChange: (index) {
                  setState(() {
                    onTabTapped(index);
                    _currentIndex = index;
                  });
                }),
          ),
        ),
      ),
    );
  }

}