import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helpful_app/onboard.dart';
import 'package:helpful_app/screens/add_screen.dart';
import 'package:helpful_app/screens/addpatient_screen.dart';
import 'package:helpful_app/screens/allpatient_screen.dart';
import 'package:helpful_app/screens/changepasswordsuccessful_screen.dart';
import 'package:helpful_app/screens/home_screen.dart';
import 'package:helpful_app/screens/user_screen.dart';
import 'package:helpful_app/screens/patient_screen.dart';
import 'screens/editpatient_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/forgotpassword_screen.dart';
import 'screens/resetpassword_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // make the device only on portrait mode.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Helpful Enterprise',
      theme: ThemeData(
        primaryColor: Color(0xFF0199FA),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        'loginScreen': (context) => LoginScreen(),
        'forgotPasswordScreen': (context) => ForgotPasswordScreen(),
        'resetPasswordScreen': (context) => ResetPasswordScreen(),
        'changePasswordSuccessful': (context) => ChangePasswordSuccessful(),
        'onBoard': (context) => OnBoard(),
        'homeScreen': (context) => HomeScreen(),
        'allPatientScreen': (context) => AllPatientScreen(),
        'addScreen': (context) => AddScreen(),
        'addPatientScreen': (context) => AddPatientScreen(),
        'userScreen': (context) => UserScreen(),
        'patientScreen': (context) => PatientScreen(),
        'editPatientScreen': (context) => EditPatientScreen(),
      },
    );
  }
}
