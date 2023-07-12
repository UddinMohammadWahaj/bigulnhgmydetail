import 'package:bigul_ekyc/BigulBindings.dart';
import 'package:bigul_ekyc/screen/adhaar_esign/AdharEsignScreen.dart';
import 'package:bigul_ekyc/screen/bank/EnterBankScreen.dart';
import 'package:bigul_ekyc/screen/bank_proof/BankProofScreen.dart';
import 'package:bigul_ekyc/screen/congratulations/CongratulationsScreen.dart';
import 'package:bigul_ekyc/screen/email_mobile/SplashScreen.dart';
import 'package:bigul_ekyc/screen/pan/DigioFirstScreen.dart';
import 'package:bigul_ekyc/screen/pan/PanVerificationScreen.dart';
import 'package:bigul_ekyc/screen/segment/SegmentDetailsScreen.dart';
import 'package:bigul_ekyc/screen/selfie/SelfieScreen.dart';
import 'package:bigul_ekyc/screen/signature/SignatureScreen.dart';
import 'package:bigul_ekyc/utils/BigulTheme.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main() async {
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor:
          Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
          statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark
              ? Brightness.light
              : Brightness.dark,
          statusBarBrightness:  Theme.of(context).brightness == Brightness.dark
              ? Brightness.light
              : Brightness.dark
      ),
    );

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bigul eKyc',
      theme: lightTheme,
      darkTheme: darkTheme,
      home: SplashScreen(),
      initialBinding: SplashBindings(),
      // home:  const AdhaarEsignScreen(),
      // initialBinding: AdhaarEsignScreenBindings(mobile: "8982042637",callBefore: true,pan: "EMOPK7481M"),
    );
  }
}
