import 'package:ASmartApp/screens/barcodescan/barcodescan_screen.dart';
import 'package:ASmartApp/screens/cameragallery/camera_gallery_screen.dart';
import 'package:ASmartApp/screens/changepassword/changepassword_screen.dart';
import 'package:ASmartApp/screens/contactus/contactus_screen.dart';
import 'package:ASmartApp/screens/dashboard/dashboard_screen.dart';
import 'package:ASmartApp/screens/drawer/baac_news_screen.dart';
import 'package:ASmartApp/screens/drawer/cancel_account_screen.dart';
import 'package:ASmartApp/screens/employeedetail/employeedetail.dart';
import 'package:ASmartApp/screens/lockscreen/locksceen.dart';
import 'package:ASmartApp/screens/onboarding/onboarding_screen.dart';
import 'package:ASmartApp/screens/onboarding/test.dart';
import 'package:ASmartApp/screens/register/register_screen.dart';
import 'package:ASmartApp/screens/servicemap/servicemap_screen.dart';
import 'package:ASmartApp/screens/setpassword/setpassword_screen.dart';
import 'package:ASmartApp/screens/showtimedetail/showtimedetail.dart';
import 'package:ASmartApp/screens/welcome/welcome_screen.dart';
import 'package:ASmartApp/screens/consent/consent_screen.dart';
import 'package:ASmartApp/screens/pincode/pincode_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/onboarding": (BuildContext context) => OnboardingScreen(),
  "/welcome": (BuildContext context) => WelcomeScreen(),
  "/register": (BuildContext context) => RegisterScreen(),
  "/consent": (BuildContext context) => ConsentScreen(),
  "/pincode": (BuildContext context) => PinCodeScreen(),
  "/setpassword": (BuildContext context) => SetPasswordScreen(),
  "/dashboard": (BuildContext context) => DashboardScreen(),
  "/baacnews": (BuildContext context) => BaacNews(),
  "/cancelaccount": (BuildContext context) => CancelAccount(),
  "/lockscreen": (BuildContext context) => LockScreen(),
  "/changepassword": (BuildContext context) => ChangePasswordScreen(),
  "/employeedetail": (BuildContext context) => EmployeeDetailScreen(),
  "/contactus": (BuildContext context) => ContactusScreen(),
  "/servicemap": (BuildContext context) => ServiceMapScreen(),
  "/camera_and_upload": (BuildContext context) => CameraGalleryScreen(),
  "/showtimedetail": (BuildContext context) => ShowTimeDetail(),
  "/barcodescan": (BuildContext context) => BarcodeScanScreen(),
  "/scan": (BuildContext context) => BarcodeScanScreen(),
  '/test': (BuildContext context) => Test(),
};
