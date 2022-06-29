import 'package:doctor_appointment/authentication_screen/log_in.dart';
import 'package:doctor_appointment/authentication_screen/login_profile_screen.dart';
import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/resources/push_notification.dart';
import 'package:doctor_appointment/splash_screen/splash_screen.dart';
import 'package:doctor_appointment/user_screen/main_screen_home/main_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

final notifyC = NotificationControl();
 GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 

  @override
  void initState() {
    notifyC.requestPermission();
    notifyC.loadFCM();
    notifyC.listenFCM();

    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: ((context, orientation, deviceType) => GetMaterialApp(
            navigatorKey: navigatorKey,
            title: 'Flutter Demo',
            theme: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              //scaffoldBackgroundColor: Colors.grey.shade200,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
              ),
              primarySwatch: Colors.blue,
              dialogTheme: DialogTheme(
                backgroundColor: kWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      return const MainHomeScreen();
                    }

                    return const LoginProfileScreen();
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                  } else {
                    return LogInScreen();
                  }
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SplashScreen();
                }
                return LogInScreen();
              },
            ),
            debugShowCheckedModeBanner: false,
          )),
    );
  }
}
