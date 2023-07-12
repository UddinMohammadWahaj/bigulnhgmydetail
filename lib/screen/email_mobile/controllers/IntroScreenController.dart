import 'package:bigul_ekyc/BigulBindings.dart';
import 'package:bigul_ekyc/api/dio_client.dart';
import 'package:bigul_ekyc/dialogs/DialogManager.dart';
import 'package:bigul_ekyc/main.dart';
import 'package:bigul_ekyc/screen/email_mobile/MobileRegistrationScreen.dart';
import 'package:bigul_ekyc/screen/email_mobile/VerificationOtpScreen.dart';
import 'package:bigul_ekyc/utils/DialogUtils.dart';
import 'package:bigul_ekyc/utils/EventKeys.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';


class IntroScreenController extends GetxController {
  final DioClient dioClient;

  IntroScreenController({required this.dioClient});

  List<String> scopes = <String>['email',
  ];
  GoogleSignIn? _googleSignIn;
  @override
  void onInit() {

    super.onInit();



    _googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: 'your-client_id.apps.googleusercontent.com',
    scopes: scopes
    );
    _googleSignIn?.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
      // In mobile, being authenticated means being authorized...
      bool isAuthorized = account != null;
      // However, in the web...
      if (kIsWeb && account != null) {
        isAuthorized = await _googleSignIn!.canAccessScopes(scopes);
      }

      _currentUser = account;
      _isAuthorized = isAuthorized;


      // Now that we know that the user can access the required scopes, the app
      // can call the REST API.
      if (isAuthorized) {

      }
    });

    // In the web, _googleSignIn.signInSilently() triggers the One Tap UX.
    //
    // It is recommended by Google Identity Services to render both the One Tap UX
    // and the Google Sign In button together to "reduce friction and improve
    // sign-in rates" ([docs](https://developers.google.com/identity/gsi/web/guides/display-button#html)).
    _googleSignIn?.signInSilently();

  }

  RxBool isValidMobile = true.obs;
  TextEditingController numberController = TextEditingController();
  var phoneFormatter = MaskTextInputFormatter(mask: "##### #####");

  Future<void> goToVerificationOtpScreen(BuildContext context) async {

    EventKeys.getOtp(numberController.text.removeAllWhitespace);

    FocusScope.of(context).unfocus();
    if(onPhoneValidation(numberController.text.removeAllWhitespace)){
      DialogUtils.showDialog(context);
      await dioClient.login(numberController.text.removeAllWhitespace).then((value) {
        DialogUtils.hideProgress(context);
        if (value.status == 200) {
          Get.off(() => const VerificationOtpScreen(),
              binding: VerificationOtpScreenBindings(number: numberController.text,email: ""),
              transition: Transition.rightToLeft);
        }
      }).onError((error, stackTrace) {
        DialogUtils.hideProgress(context).then((value) {
        });
      });
    }
  }

  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false;



  Future<void> onPressGoogleSignIn(BuildContext context) async {

    try {
      _currentUser =   await _googleSignIn!.signIn();
      print(_currentUser.toString());
      EventKeys.signInGoogle(_currentUser!.email);


      DialogManager.showEmailVerifiedDialog(context).then((value) {
        if (value == true) {
          Get.off(() => const MobileRegistrationScreen(),
              binding: MobileRegistrationScreenBinding(email : _currentUser!.email),
              transition: Transition.rightToLeft);
        }
      });

    } catch (error) {
      print("asdfa $error");
    }







  }

  bool startsWithZeroToFive(String input) {
    RegExp regex = RegExp(r'^[0-5]');
    return regex.hasMatch(input);
  }

  bool onPhoneValidation(String? value) {

    isValidMobile.value = false;
    if (value!.isEmpty) {
      return false;
    } else if (value.length != 10) {
      return false;
    }else if(startsWithZeroToFive(value)){
      return false;
    }
    else {
      EventKeys.enterMobileNumber(value);
      isValidMobile.value = true;
      return true;
    }
  }



}
