import 'dart:convert';

import 'package:bigul_ekyc/main.dart';

class EventKeys {
  static const String CREATE_ACCOUNT = "create_account";
  static const String SIGN_IN_GOOGLE = "sign_in_google";
  static const String ENTER_MOBILE_NO = "enter_mobile_no";
  static const String GET_OTP = "get_otp";
  static const String EDIT_MOBILE = "edit_mobile";
  static const String RESEND_OTP = "resend_otp";
  static const String VERIFY_MOBILE_NUMBER = "verify_mobile_number";
  static const String MOBILE_VERIFIED = "mobile_verified";
  static const String ENTER_EMAIL_ADDRESS = "enter_email_address";
  static const String SEND_OTP = "send_otp";
  static const String EMAIL_OTP_SENT = "email_otp_sent";
  static const String RESEND_EMAIL_OTP = "resend_email_otp";
  static const String VERIFY_EMAIL_ADDRESS = "verify_email_address";
  static const String EMAIL_VERIFIED = "email_verified";
  static const String ENTER_PAN = "enter_pan";
  static const String RE_ENTER_PAN_DETAILS = "re_enter_pan_details";
  static const String ENTER_DOB = "enter_dob";
  static const String VERIFY_PAN = "verify_pan";
  static const String CONFIRM_ITS_YOU = "confirm_its_you";
  static const String DIGI_LOCKER_ACCESS = "digi_locker_access";
  static const String ALLOW_ACCESS = "allow_access";
  static const String FETCH_DOCUMENTS_DIGILOCKER = "fetch_documents_digilocker";
  static const String AUTHENTICATE_AADHAR = "authenticate_aadhar"; //TODO
  static const String ENTER_AADHAR = "enter_aadhar"; //TODO
  static const String ENTER_TEXT = "enter_text"; //TODO
  static const String ENTER_OTP = "enter_otp";  //TODO
  static const String SELFIE_KYC = "selfie_kyc";  //TODO
  static const String FETCH_DOCUMENTS_KRA = "fetch_documents_kra";
  static const String GENDER = "gender";
  static const String MARITAL_STATUS = "marital_status";
  static const String FATHER_SPOUSE_NAME = "father_spouse_name";
  static const String CITY_OF_BIRTH = "city_of_birth";
  static const String EDUCATION = "education";
  static const String OCCUPATION = "occupation";
  static const String ANNUAL_INCOME = "annual_income";
  static const String TRADING_EXPERIENCE = "trading_experience";
  static const String PROCEED_BANK_VERIFICATION = "proceed_bank_verification";
  static const String ENTER_BANK_NAME_IFSC = "enter_bank_name_ifsc";
  static const String ENTER_BRANCH = "enter_branch"; //TODO
  static const String SEARCH_YOUR_BRANCH = "search_your_branch";  //TODO
  static const String ENTER_BANK_ACCOUNT_NO = "enter_bank_account_no";
  static const String CONFIRM_BANK_ACCOUNT_NO = "confirm_bank_account_no";
  static const String VERIFY_BANK_ACCOUNT_NO = "verify_bank_account_no";
  static const String BANK_ACCOUNT_NO_VERIFIED = "bank_account_no_verified";
  static const String SELECT_BANK_PROOF_TYPE = "select_bank_proof_type";
  static const String ENTER_PASSWORD_IF_ANY = "enter_password_if_any";
  static const String UPLOAD_BANK_PROOF = "upload_bank_proof";
  static const String TRADING_INVESTMENT_PREFERENCES = "trading_investment_preferences";
  static const String SELECT_INCOME_PROOF_TYPE = "select_income_proof_type";
  static const String DRAW_SIGNATURE = "draw_signature";
  static const String TAKE_PICTURE = "take_picture";
  static const String UPLOAD_SIGNATURE = "upload_signature";
  static const String ADHAR_ESIGN = "adhar_esign";

  static Future<void> userId(String userId) async {
    await MyApp.analytics.setUserId(id:userId);
    await MyApp.analytics.setUserProperty(name: "userId",value: userId);

  }

  static Future<void> createAccount(String number) async {
    await MyApp.analytics
        .logEvent(name: CREATE_ACCOUNT, parameters: {"number": number});
  }

  static Future<void> signInGoogle(String email) async {
    await MyApp.analytics
        .logEvent(name: SIGN_IN_GOOGLE, parameters: {"email": email});
  }

  static Future<void> enterMobileNumber(String number) async {
    await MyApp.analytics
        .logEvent(name: ENTER_MOBILE_NO, parameters: {"number": number});
  }

  static Future<void> getOtp(String number) async {
    await MyApp.analytics
        .logEvent(name: GET_OTP, parameters: {"number": number});
  }

  static Future<void> editMobile(String number) async {
    await MyApp.analytics
        .logEvent(name: EDIT_MOBILE, parameters: {"number": number});
  }

  static Future<void> resendOtp(String number) async {
    await MyApp.analytics
        .logEvent(name: RESEND_OTP, parameters: {"number": number});
  }

  static Future<void> verifyMobileNumber(String number) async {
    await MyApp.analytics.logEvent(
        name: VERIFY_MOBILE_NUMBER, parameters: {"number": number});
  }

  static Future<void> mobileVerified(String number) async {

    await MyApp.analytics
        .logEvent(name: MOBILE_VERIFIED, parameters: {"number": number} );
  }

  static Future<void> enterEmailAddress(String number,String email) async {
    await MyApp.analytics.logEvent(
        name: ENTER_EMAIL_ADDRESS,
        parameters: {"number": number,"email":email});
  }

  static Future<void> sendOtp(String number) async {
    await MyApp.analytics.logEvent(
        name: SEND_OTP, parameters: {"number": number});
  }

  static Future<void> emailOtpSent(
      String number) async {
    await MyApp.analytics.logEvent(
        name: EMAIL_OTP_SENT,
        parameters: {"number": number});
  }

  static Future<void> resendEmailOtpSent(String number) async {
    await MyApp.analytics.logEvent(
        name: RESEND_EMAIL_OTP, parameters: {"number": number});
  }

  static Future<void> verifyEmailAddress(String number) async {
    await MyApp.analytics.logEvent(
        name: VERIFY_EMAIL_ADDRESS,
        parameters: {"number": number});
  }

  static Future<void> emailVerified(String number, ) async {
    await MyApp.analytics.logEvent(
        name: EMAIL_VERIFIED, parameters: {"number": number});
  }

  static Future<void> enterPan(String number,String pan) async {
    await MyApp.analytics
        .logEvent(name: ENTER_PAN, parameters: {"number": number,"pan":pan});
  }

  static Future<void> enterDOB(String number) async {
    await MyApp.analytics.logEvent(
        name: ENTER_DOB,
        parameters: {"number": number});
  }

  static Future<void> verifyPan(String number) async {
    await MyApp.analytics.logEvent(
        name: VERIFY_PAN,
        parameters: {"number": number});
  }

  static Future<void> renterPanDetails(String number) async {
    await MyApp.analytics
        .logEvent(name: RE_ENTER_PAN_DETAILS, parameters: {"number": number});
  }

  static Future<void> confirmItsYou(String number) async {
    await MyApp.analytics
        .logEvent(name: CONFIRM_ITS_YOU, parameters: {"number": number});
  }

  static Future<void> digilockerAccess(String number) async {
    await MyApp.analytics
        .logEvent(name: DIGI_LOCKER_ACCESS, parameters: {"number": number});
  }

  static Future<void> allowAccess(String number) async {
    await MyApp.analytics
        .logEvent(name: ALLOW_ACCESS, parameters: {"number": number});
  }

  static Future<void> fetcDigilocker(String number) async {

    await MyApp.analytics
        .logEvent(name: FETCH_DOCUMENTS_DIGILOCKER, parameters:{"number": number});
  }

  static Future<void> fetcKRA(String number) async {

    await MyApp.analytics
        .logEvent(name: FETCH_DOCUMENTS_KRA, parameters: {"number": number});
  }

  static Future<void> gender(String number) async {
    await MyApp.analytics
        .logEvent(name: GENDER, parameters: {"number": number});
  }
  static Future<void> maritalStatus(String number) async {
    await MyApp.analytics
        .logEvent(name: MARITAL_STATUS, parameters: {"number": number});
  }
  static Future<void> fatherSpouse(String number) async {
    await MyApp.analytics
        .logEvent(name: FATHER_SPOUSE_NAME, parameters: {"number": number});
  }
  static Future<void> cityOfBirth(String number) async {
    await MyApp.analytics
        .logEvent(name: CITY_OF_BIRTH, parameters: {"number": number});
  }

  static Future<void> education(String number) async {
    await MyApp.analytics
        .logEvent(name: EDUCATION, parameters: {"number": number});
  }

  static Future<void> occupation(String number) async {
    await MyApp.analytics
        .logEvent(name: OCCUPATION, parameters: {"number": number});
  }

  static Future<void> annualIncome(String number) async {
    await MyApp.analytics
        .logEvent(name: ANNUAL_INCOME, parameters: {"number": number});
  }

  static Future<void> tradingExperience(String number) async {
    await MyApp.analytics
        .logEvent(name: TRADING_EXPERIENCE, parameters: {"number": number});
  }

  static Future<void> proceedBankVerification(String number) async {
    await MyApp.analytics
        .logEvent(name: PROCEED_BANK_VERIFICATION, parameters: {"number": number});
  }
  static Future<void> enterBankNameIFSC(String number) async {
    await MyApp.analytics
        .logEvent(name: ENTER_BANK_NAME_IFSC, parameters: {"number": number});
  }

  static Future<void> enterBankAccountNo(String number) async {
    await MyApp.analytics
        .logEvent(name: ENTER_BANK_ACCOUNT_NO, parameters: {"number": number});
  }

  static Future<void> enterConfirmBankAccountNo(String number) async {
    await MyApp.analytics
        .logEvent(name: CONFIRM_BANK_ACCOUNT_NO, parameters: {"number": number});
  }

  static Future<void> verifyBankAccoutNo(String number) async {
    await MyApp.analytics
        .logEvent(name: VERIFY_BANK_ACCOUNT_NO, parameters: {"number": number});
  }

  static Future<void> bankVerified(String number) async {
    await MyApp.analytics
        .logEvent(name: BANK_ACCOUNT_NO_VERIFIED, parameters: {"number": number});
  }

  static Future<void> selectBankProofType(String number) async {
    await MyApp.analytics
        .logEvent(name: SELECT_BANK_PROOF_TYPE, parameters: {"number": number});
  }
  static Future<void> uploadBankProof(String number) async {
    await MyApp.analytics
        .logEvent(name: UPLOAD_BANK_PROOF, parameters: {"number": number});
  }
  static Future<void> tradingPrefrences(String number) async {
    await MyApp.analytics
        .logEvent(name: TRADING_INVESTMENT_PREFERENCES, parameters: {"number": number});
  }

  static Future<void> incomeProofType(String number) async {
    await MyApp.analytics
        .logEvent(name: SELECT_INCOME_PROOF_TYPE, parameters: {"number": number});
  }

  static Future<void> drawSignature(String number) async {
    await MyApp.analytics
        .logEvent(name: DRAW_SIGNATURE, parameters: {"number": number});
  }

  static Future<void> takePicture(String number) async {
    await MyApp.analytics
        .logEvent(name: TAKE_PICTURE, parameters: {"number": number});
  }

  static Future<void> uploadSignature(String number) async {
    await MyApp.analytics
        .logEvent(name: UPLOAD_SIGNATURE, parameters: {"number": number});
  }

  static Future<void> adhaarEsign(String number) async {
    await MyApp.analytics
        .logEvent(name: ADHAR_ESIGN, parameters: {"number": number});
  }
}
