// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `MSDF E-Services Citizen`
  String get appName {
    return Intl.message(
      'MSDF E-Services Citizen',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Something went wrong, please try again later.`
  String get Somethingwentwrongpleasetryagainlater {
    return Intl.message(
      'Something went wrong, please try again later.',
      name: 'Somethingwentwrongpleasetryagainlater',
      desc: '',
      args: [],
    );
  }

  /// `Connection timeout or network error.`
  String get connectionTimeOutOrNetworkError {
    return Intl.message(
      'Connection timeout or network error.',
      name: 'connectionTimeOutOrNetworkError',
      desc: '',
      args: [],
    );
  }

  /// `SSL certificate is invalid.`
  String get sslCertificateIsInvalid {
    return Intl.message(
      'SSL certificate is invalid.',
      name: 'sslCertificateIsInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Server error`
  String get Servererror {
    return Intl.message(
      'Server error',
      name: 'Servererror',
      desc: '',
      args: [],
    );
  }

  /// `Request was cancelled.`
  String get RequestWasCancelled {
    return Intl.message(
      'Request was cancelled.',
      name: 'RequestWasCancelled',
      desc: '',
      args: [],
    );
  }

  /// `No Internet connection.`
  String get NoInternetConnection {
    return Intl.message(
      'No Internet connection.',
      name: 'NoInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected error occurred.`
  String get UnexpectedErrorOccurred {
    return Intl.message(
      'Unexpected error occurred.',
      name: 'UnexpectedErrorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `Learn about government service details`
  String get LearnAboutGovernmentServiceDetails {
    return Intl.message(
      'Learn about government service details',
      name: 'LearnAboutGovernmentServiceDetails',
      desc: '',
      args: [],
    );
  }

  /// `We provide you with all the details of the available government services and automatically verify that you meet the requirements`
  String get governmentServicesDetails {
    return Intl.message(
      'We provide you with all the details of the available government services and automatically verify that you meet the requirements',
      name: 'governmentServicesDetails',
      desc: '',
      args: [],
    );
  }

  /// `Fill the application form`
  String get FillTheApplicationForm {
    return Intl.message(
      'Fill the application form',
      name: 'FillTheApplicationForm',
      desc: '',
      args: [],
    );
  }

  /// `Smart forms to receive your data and documents in an intuitive and easy way`
  String get smartFormsDescription {
    return Intl.message(
      'Smart forms to receive your data and documents in an intuitive and easy way',
      name: 'smartFormsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Track your request until it is completed`
  String get trackRequest {
    return Intl.message(
      'Track your request until it is completed',
      name: 'trackRequest',
      desc: '',
      args: [],
    );
  }

  /// `Stay updated on the status of your request through smart communication and the ability to edit data when needed`
  String get requestTracking {
    return Intl.message(
      'Stay updated on the status of your request through smart communication and the ability to edit data when needed',
      name: 'requestTracking',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Continue`
  String get continue_progress {
    return Intl.message(
      'Continue',
      name: 'continue_progress',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Login using the National Authentication System`
  String get loginWithNationalAuth {
    return Intl.message(
      'Login using the National Authentication System',
      name: 'loginWithNationalAuth',
      desc: '',
      args: [],
    );
  }

  /// `Log in to submit and track various government service requests`
  String get loginForServices {
    return Intl.message(
      'Log in to submit and track various government service requests',
      name: 'loginForServices',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message('Username', name: 'username', desc: '', args: []);
  }

  /// `Please enter your personal number or email address`
  String get enterPersonalOrEmail {
    return Intl.message(
      'Please enter your personal number or email address',
      name: 'enterPersonalOrEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Please enter your password`
  String get enterPassword {
    return Intl.message(
      'Please enter your password',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot your password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Not a member yet?`
  String get notAMemberYet {
    return Intl.message(
      'Not a member yet?',
      name: 'notAMemberYet',
      desc: '',
      args: [],
    );
  }

  /// `Register Now`
  String get registerNow {
    return Intl.message(
      'Register Now',
      name: 'registerNow',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid personal number or email address`
  String get enterValidPersonalOrEmail {
    return Intl.message(
      'Please enter a valid personal number or email address',
      name: 'enterValidPersonalOrEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid password`
  String get enterValidPassword {
    return Intl.message(
      'Please enter a valid password',
      name: 'enterValidPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enjoy over 60 government services provided by the Ministry of Social Development and Family`
  String get enjoyGovServices {
    return Intl.message(
      'Enjoy over 60 government services provided by the Ministry of Social Development and Family',
      name: 'enjoyGovServices',
      desc: '',
      args: [],
    );
  }

  /// `Enter service name...`
  String get enterServiceName {
    return Intl.message(
      'Enter service name...',
      name: 'enterServiceName',
      desc: '',
      args: [],
    );
  }

  /// `Most Popular Services`
  String get mostPopularServices {
    return Intl.message(
      'Most Popular Services',
      name: 'mostPopularServices',
      desc: '',
      args: [],
    );
  }

  /// `All Services`
  String get allServices {
    return Intl.message(
      'All Services',
      name: 'allServices',
      desc: '',
      args: [],
    );
  }

  /// `Get the service`
  String get getService {
    return Intl.message(
      'Get the service',
      name: 'getService',
      desc: '',
      args: [],
    );
  }

  /// `Log in to access the services`
  String get loginToGetServices {
    return Intl.message(
      'Log in to access the services',
      name: 'loginToGetServices',
      desc: '',
      args: [],
    );
  }

  /// `Please log in to be able to submit requests for our services`
  String get pleaseLoginToRequestServices {
    return Intl.message(
      'Please log in to be able to submit requests for our services',
      name: 'pleaseLoginToRequestServices',
      desc: '',
      args: [],
    );
  }

  /// `Latest news and announcements`
  String get latestNewsAndAnnouncements {
    return Intl.message(
      'Latest news and announcements',
      name: 'latestNewsAndAnnouncements',
      desc: '',
      args: [],
    );
  }

  /// `All Articles`
  String get allArticles {
    return Intl.message(
      'All Articles',
      name: 'allArticles',
      desc: '',
      args: [],
    );
  }

  /// `Social Security`
  String get serviceTitle {
    return Intl.message(
      'Social Security',
      name: 'serviceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Service Details`
  String get serviceDetails {
    return Intl.message(
      'Service Details',
      name: 'serviceDetails',
      desc: '',
      args: [],
    );
  }

  /// `Submit Social Security Service Request`
  String get serviceRequest {
    return Intl.message(
      'Submit Social Security Service Request',
      name: 'serviceRequest',
      desc: '',
      args: [],
    );
  }

  /// `This service allows you to apply for a social security pension for the following categories: widow, divorced woman, needy family, person with disability, orphan, person unable to work, elderly, prisoner’s family, abandoned wife, and deceased’s family, as well as domestic worker allowance. Cabinet Decision No. (46) of 2014 specifies the pension value entitled to the categories stipulated in Law No. (38) of 1995 on Social Security and its granting rules.`
  String get serviceDescription {
    return Intl.message(
      'This service allows you to apply for a social security pension for the following categories: widow, divorced woman, needy family, person with disability, orphan, person unable to work, elderly, prisoner’s family, abandoned wife, and deceased’s family, as well as domestic worker allowance. Cabinet Decision No. (46) of 2014 specifies the pension value entitled to the categories stipulated in Law No. (38) of 1995 on Social Security and its granting rules.',
      name: 'serviceDescription',
      desc: '',
      args: [],
    );
  }

  /// `Show more...`
  String get seeMore {
    return Intl.message('Show more...', name: 'seeMore', desc: '', args: []);
  }

  /// `End of request (maximum 30 days)`
  String get requestEnd {
    return Intl.message(
      'End of request (maximum 30 days)',
      name: 'requestEnd',
      desc: '',
      args: [],
    );
  }

  /// `Acceptance or Rejection`
  String get acceptOrReject {
    return Intl.message(
      'Acceptance or Rejection',
      name: 'acceptOrReject',
      desc: '',
      args: [],
    );
  }

  /// `Maximum 13 days`
  String get max13Days {
    return Intl.message(
      'Maximum 13 days',
      name: 'max13Days',
      desc: '',
      args: [],
    );
  }

  /// `Personal Inquiry`
  String get personalInquiry {
    return Intl.message(
      'Personal Inquiry',
      name: 'personalInquiry',
      desc: '',
      args: [],
    );
  }

  /// `Review Request Data`
  String get reviewRequestData {
    return Intl.message(
      'Review Request Data',
      name: 'reviewRequestData',
      desc: '',
      args: [],
    );
  }

  /// `Submit Request`
  String get submitRequest {
    return Intl.message(
      'Submit Request',
      name: 'submitRequest',
      desc: '',
      args: [],
    );
  }

  /// `Maximum 5 days`
  String get max5Days {
    return Intl.message('Maximum 5 days', name: 'max5Days', desc: '', args: []);
  }

  /// `Request Stages`
  String get requestStages {
    return Intl.message(
      'Request Stages',
      name: 'requestStages',
      desc: '',
      args: [],
    );
  }

  /// `Apply Now`
  String get applyNow {
    return Intl.message('Apply Now', name: 'applyNow', desc: '', args: []);
  }

  /// `View Required Documents`
  String get viewRequiredDocuments {
    return Intl.message(
      'View Required Documents',
      name: 'viewRequiredDocuments',
      desc: '',
      args: [],
    );
  }

  /// `View Conditions`
  String get viewConditions {
    return Intl.message(
      'View Conditions',
      name: 'viewConditions',
      desc: '',
      args: [],
    );
  }

  /// `Eligible`
  String get eligible {
    return Intl.message('Eligible', name: 'eligible', desc: '', args: []);
  }

  /// `Maximum time to complete the request`
  String get maxCompletionTime {
    return Intl.message(
      'Maximum time to complete the request',
      name: 'maxCompletionTime',
      desc: '',
      args: [],
    );
  }

  /// `Service Fees`
  String get serviceFees {
    return Intl.message(
      'Service Fees',
      name: 'serviceFees',
      desc: '',
      args: [],
    );
  }

  /// `Service Type`
  String get serviceType {
    return Intl.message(
      'Service Type',
      name: 'serviceType',
      desc: '',
      args: [],
    );
  }

  /// `Electronic`
  String get electronic {
    return Intl.message('Electronic', name: 'electronic', desc: '', args: []);
  }

  /// `20 Qatari Riyals`
  String get serviceFee20QAR {
    return Intl.message(
      '20 Qatari Riyals',
      name: 'serviceFee20QAR',
      desc: '',
      args: [],
    );
  }

  /// `30 working days`
  String get processingTime30Days {
    return Intl.message(
      '30 working days',
      name: 'processingTime30Days',
      desc: '',
      args: [],
    );
  }

  /// `Show Conditions`
  String get showConditions {
    return Intl.message(
      'Show Conditions',
      name: 'showConditions',
      desc: '',
      args: [],
    );
  }

  /// `Required Documents`
  String get requiredDocuments {
    return Intl.message(
      'Required Documents',
      name: 'requiredDocuments',
      desc: '',
      args: [],
    );
  }

  /// `View`
  String get view {
    return Intl.message('View', name: 'view', desc: '', args: []);
  }

  /// `Not Eligible`
  String get notEligible {
    return Intl.message(
      'Not Eligible',
      name: 'notEligible',
      desc: '',
      args: [],
    );
  }

  /// `Hide Conditions`
  String get hideConditions {
    return Intl.message(
      'Hide Conditions',
      name: 'hideConditions',
      desc: '',
      args: [],
    );
  }

  /// `hide`
  String get hide {
    return Intl.message('hide', name: 'hide', desc: '', args: []);
  }

  /// `Social Security Subscription`
  String get socialSecuritySubscription {
    return Intl.message(
      'Social Security Subscription',
      name: 'socialSecuritySubscription',
      desc: '',
      args: [],
    );
  }

  /// `ID Card`
  String get idCard {
    return Intl.message('ID Card', name: 'idCard', desc: '', args: []);
  }

  /// `Optional`
  String get optional {
    return Intl.message('Optional', name: 'optional', desc: '', args: []);
  }

  /// `Mandatory`
  String get mandatory {
    return Intl.message('Mandatory', name: 'mandatory', desc: '', args: []);
  }

  /// `You cannot submit a request because you do not meet some of the conditions`
  String get cannotSubmitRequest {
    return Intl.message(
      'You cannot submit a request because you do not meet some of the conditions',
      name: 'cannotSubmitRequest',
      desc: '',
      args: [],
    );
  }

  /// `Send Request`
  String get sendRequest {
    return Intl.message(
      'Send Request',
      name: 'sendRequest',
      desc: '',
      args: [],
    );
  }

  /// `Social Security`
  String get socialSecurity {
    return Intl.message(
      'Social Security',
      name: 'socialSecurity',
      desc: '',
      args: [],
    );
  }

  /// `Please review the entered data carefully before submission. You will not be able to modify the request data or attachments after this step.`
  String get reviewBeforeSubmit {
    return Intl.message(
      'Please review the entered data carefully before submission. You will not be able to modify the request data or attachments after this step.',
      name: 'reviewBeforeSubmit',
      desc: '',
      args: [],
    );
  }

  /// `Submit Social Security Service Request`
  String get submitSocialSecurityRequest {
    return Intl.message(
      'Submit Social Security Service Request',
      name: 'submitSocialSecurityRequest',
      desc: '',
      args: [],
    );
  }

  /// `Entered Data`
  String get enteredData {
    return Intl.message(
      'Entered Data',
      name: 'enteredData',
      desc: '',
      args: [],
    );
  }

  /// `Total Salary`
  String get salaryTotal {
    return Intl.message(
      'Total Salary',
      name: 'salaryTotal',
      desc: '',
      args: [],
    );
  }

  /// `Retirement Salary`
  String get retirementSalary {
    return Intl.message(
      'Retirement Salary',
      name: 'retirementSalary',
      desc: '',
      args: [],
    );
  }

  /// `Commercial Registration Number`
  String get commercialRegistrationNumber {
    return Intl.message(
      'Commercial Registration Number',
      name: 'commercialRegistrationNumber',
      desc: '',
      args: [],
    );
  }

  /// `Real Estate Registration Number`
  String get realEstateRegistrationNumber {
    return Intl.message(
      'Real Estate Registration Number',
      name: 'realEstateRegistrationNumber',
      desc: '',
      args: [],
    );
  }

  /// `Inheritance Share`
  String get inheritanceShare {
    return Intl.message(
      'Inheritance Share',
      name: 'inheritanceShare',
      desc: '',
      args: [],
    );
  }

  /// `Domestic Worker Allowance`
  String get domesticWorkerAllowance {
    return Intl.message(
      'Domestic Worker Allowance',
      name: 'domesticWorkerAllowance',
      desc: '',
      args: [],
    );
  }

  /// `Mandatory Documents Added`
  String get mandatoryDocuments {
    return Intl.message(
      'Mandatory Documents Added',
      name: 'mandatoryDocuments',
      desc: '',
      args: [],
    );
  }

  /// `Added`
  String get added {
    return Intl.message('Added', name: 'added', desc: '', args: []);
  }

  /// `Not Added`
  String get notAdded {
    return Intl.message('Not Added', name: 'notAdded', desc: '', args: []);
  }

  /// `Social Security Card`
  String get socialSecurityCard {
    return Intl.message(
      'Social Security Card',
      name: 'socialSecurityCard',
      desc: '',
      args: [],
    );
  }

  /// `Commitment`
  String get commitment {
    return Intl.message('Commitment', name: 'commitment', desc: '', args: []);
  }

  /// `Real Estate Registration Documents`
  String get realEstateRegistrationDocs {
    return Intl.message(
      'Real Estate Registration Documents',
      name: 'realEstateRegistrationDocs',
      desc: '',
      args: [],
    );
  }

  /// `Bank Certificate (IBAN)`
  String get bankCertificateIBAN {
    return Intl.message(
      'Bank Certificate (IBAN)',
      name: 'bankCertificateIBAN',
      desc: '',
      args: [],
    );
  }

  /// `Entry/Exit Record`
  String get entryExitRecord {
    return Intl.message(
      'Entry/Exit Record',
      name: 'entryExitRecord',
      desc: '',
      args: [],
    );
  }

  /// `Optional Documents Added`
  String get optionalDocuments {
    return Intl.message(
      'Optional Documents Added',
      name: 'optionalDocuments',
      desc: '',
      args: [],
    );
  }

  /// `Certificate of Non-Marriage`
  String get marriageStatusCertificate {
    return Intl.message(
      'Certificate of Non-Marriage',
      name: 'marriageStatusCertificate',
      desc: '',
      args: [],
    );
  }

  /// `Rental Contract`
  String get rentalContract {
    return Intl.message(
      'Rental Contract',
      name: 'rentalContract',
      desc: '',
      args: [],
    );
  }

  /// `I declare that the entered data is correct and that the attached documents are original and obtained from their authentic sources.`
  String get declaration {
    return Intl.message(
      'I declare that the entered data is correct and that the attached documents are original and obtained from their authentic sources.',
      name: 'declaration',
      desc: '',
      args: [],
    );
  }

  /// `Edit Data`
  String get editData {
    return Intl.message('Edit Data', name: 'editData', desc: '', args: []);
  }

  /// `If there is a server issue, the request was not sent.`
  String get serverError {
    return Intl.message(
      'If there is a server issue, the request was not sent.',
      name: 'serverError',
      desc: '',
      args: [],
    );
  }

  /// `10,000 Qatari Riyals`
  String get amountQAR {
    return Intl.message(
      '10,000 Qatari Riyals',
      name: 'amountQAR',
      desc: '',
      args: [],
    );
  }

  /// `{action} completed successfully`
  String successMessage(Object action) {
    return Intl.message(
      '$action completed successfully',
      name: 'successMessage',
      desc: '',
      args: [action],
    );
  }

  /// `Your request has entered the processing stage. You can track the status of the request from the platform or through the application.`
  String get requestInProgress {
    return Intl.message(
      'Your request has entered the processing stage. You can track the status of the request from the platform or through the application.',
      name: 'requestInProgress',
      desc: '',
      args: [],
    );
  }

  /// `Could not {action}`
  String failedAction(Object action) {
    return Intl.message(
      'Could not $action',
      name: 'failedAction',
      desc: '',
      args: [action],
    );
  }

  /// `Sorry. It seems there is a technical issue with our servers. Your request has been saved as a draft, please try submitting it again later.`
  String get technicalErrorDraftSaved {
    return Intl.message(
      'Sorry. It seems there is a technical issue with our servers. Your request has been saved as a draft, please try submitting it again later.',
      name: 'technicalErrorDraftSaved',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get more {
    return Intl.message('More', name: 'more', desc: '', args: []);
  }

  /// `Welcome`
  String get welcome {
    return Intl.message('Welcome', name: 'welcome', desc: '', args: []);
  }

  /// `To enjoy more than 60 electronic government services, you must first register some basic information`
  String get registerBasicData {
    return Intl.message(
      'To enjoy more than 60 electronic government services, you must first register some basic information',
      name: 'registerBasicData',
      desc: '',
      args: [],
    );
  }

  /// `Data Registration`
  String get dataRegistration {
    return Intl.message(
      'Data Registration',
      name: 'dataRegistration',
      desc: '',
      args: [],
    );
  }

  /// `You can skip this step, but you will not be able to apply for the available services before registering your data`
  String get skipDataRegistrationNote {
    return Intl.message(
      'You can skip this step, but you will not be able to apply for the available services before registering your data',
      name: 'skipDataRegistrationNote',
      desc: '',
      args: [],
    );
  }

  /// `Citizen Data Registration`
  String get citizenDataRegistration {
    return Intl.message(
      'Citizen Data Registration',
      name: 'citizenDataRegistration',
      desc: '',
      args: [],
    );
  }

  /// `Continue Later`
  String get continueLater {
    return Intl.message(
      'Continue Later',
      name: 'continueLater',
      desc: '',
      args: [],
    );
  }

  /// `Please fill out the following forms to complete your registration on the platform and be able to access the available services`
  String get fillFormsToCompleteRegistration {
    return Intl.message(
      'Please fill out the following forms to complete your registration on the platform and be able to access the available services',
      name: 'fillFormsToCompleteRegistration',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Data`
  String get confirmData {
    return Intl.message(
      'Confirm Data',
      name: 'confirmData',
      desc: '',
      args: [],
    );
  }

  /// `Correspondence Addresses`
  String get correspondenceAddresses {
    return Intl.message(
      'Correspondence Addresses',
      name: 'correspondenceAddresses',
      desc: '',
      args: [],
    );
  }

  /// `Additional Data`
  String get additionalData {
    return Intl.message(
      'Additional Data',
      name: 'additionalData',
      desc: '',
      args: [],
    );
  }

  /// `Verify Data`
  String get verifyData {
    return Intl.message('Verify Data', name: 'verifyData', desc: '', args: []);
  }

  /// `Enter first name`
  String get enterFirstName {
    return Intl.message(
      'Enter first name',
      name: 'enterFirstName',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstName {
    return Intl.message('First Name', name: 'firstName', desc: '', args: []);
  }

  /// `Please enter the first name`
  String get pleaseEnterFirstName {
    return Intl.message(
      'Please enter the first name',
      name: 'pleaseEnterFirstName',
      desc: '',
      args: [],
    );
  }

  /// `Middle Name`
  String get middleName {
    return Intl.message('Middle Name', name: 'middleName', desc: '', args: []);
  }

  /// `Enter middle name`
  String get enterMiddleName {
    return Intl.message(
      'Enter middle name',
      name: 'enterMiddleName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the middle name`
  String get pleaseEnterMiddleName {
    return Intl.message(
      'Please enter the middle name',
      name: 'pleaseEnterMiddleName',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get lastName {
    return Intl.message('Last Name', name: 'lastName', desc: '', args: []);
  }

  /// `Enter last name`
  String get enterLastName {
    return Intl.message(
      'Enter last name',
      name: 'enterLastName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the last name`
  String get pleaseEnterLastName {
    return Intl.message(
      'Please enter the last name',
      name: 'pleaseEnterLastName',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message('Category', name: 'category', desc: '', args: []);
  }

  /// `Enter category`
  String get enterCategory {
    return Intl.message(
      'Enter category',
      name: 'enterCategory',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the category`
  String get pleaseEnterCategory {
    return Intl.message(
      'Please enter the category',
      name: 'pleaseEnterCategory',
      desc: '',
      args: [],
    );
  }

  /// `ID Number`
  String get idNumber {
    return Intl.message('ID Number', name: 'idNumber', desc: '', args: []);
  }

  /// `Enter ID number`
  String get enterIdNumber {
    return Intl.message(
      'Enter ID number',
      name: 'enterIdNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid ID number`
  String get pleaseEnterValidIdNumber {
    return Intl.message(
      'Please enter a valid ID number',
      name: 'pleaseEnterValidIdNumber',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Number`
  String get mobileNumber {
    return Intl.message(
      'Mobile Number',
      name: 'mobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `New Number`
  String get newNumber {
    return Intl.message('New Number', name: 'newNumber', desc: '', args: []);
  }

  /// `Enter mobile number`
  String get enterMobileNumber {
    return Intl.message(
      'Enter mobile number',
      name: 'enterMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid mobile number`
  String get pleaseEnterValidMobileNumber {
    return Intl.message(
      'Please enter a valid mobile number',
      name: 'pleaseEnterValidMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Gender`
  String get gender {
    return Intl.message('Gender', name: 'gender', desc: '', args: []);
  }

  /// `Select gender`
  String get selectGender {
    return Intl.message(
      'Select gender',
      name: 'selectGender',
      desc: '',
      args: [],
    );
  }

  /// `Please select the gender`
  String get pleaseSelectGender {
    return Intl.message(
      'Please select the gender',
      name: 'pleaseSelectGender',
      desc: '',
      args: [],
    );
  }

  /// `Your Addresses`
  String get yourAddresses {
    return Intl.message(
      'Your Addresses',
      name: 'yourAddresses',
      desc: '',
      args: [],
    );
  }

  /// `New Address`
  String get newAddress {
    return Intl.message('New Address', name: 'newAddress', desc: '', args: []);
  }

  /// `Home Address`
  String get homeAddress {
    return Intl.message(
      'Home Address',
      name: 'homeAddress',
      desc: '',
      args: [],
    );
  }

  /// `Governorate`
  String get governorate {
    return Intl.message('Governorate', name: 'governorate', desc: '', args: []);
  }

  /// `Enter governorate name`
  String get enterGovernorate {
    return Intl.message(
      'Enter governorate name',
      name: 'enterGovernorate',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the governorate name`
  String get pleaseEnterGovernorate {
    return Intl.message(
      'Please enter the governorate name',
      name: 'pleaseEnterGovernorate',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message('City', name: 'city', desc: '', args: []);
  }

  /// `Enter city name`
  String get enterCity {
    return Intl.message(
      'Enter city name',
      name: 'enterCity',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the city name`
  String get pleaseEnterCity {
    return Intl.message(
      'Please enter the city name',
      name: 'pleaseEnterCity',
      desc: '',
      args: [],
    );
  }

  /// `Street`
  String get street {
    return Intl.message('Street', name: 'street', desc: '', args: []);
  }

  /// `Enter street name`
  String get enterStreet {
    return Intl.message(
      'Enter street name',
      name: 'enterStreet',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the street name`
  String get pleaseEnterStreet {
    return Intl.message(
      'Please enter the street name',
      name: 'pleaseEnterStreet',
      desc: '',
      args: [],
    );
  }

  /// `House Number`
  String get houseNumber {
    return Intl.message(
      'House Number',
      name: 'houseNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter house number`
  String get enterHouseNumber {
    return Intl.message(
      'Enter house number',
      name: 'enterHouseNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the house number`
  String get pleaseEnterHouseNumber {
    return Intl.message(
      'Please enter the house number',
      name: 'pleaseEnterHouseNumber',
      desc: '',
      args: [],
    );
  }

  /// `Building Number`
  String get buildingNumber {
    return Intl.message(
      'Building Number',
      name: 'buildingNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter building number`
  String get enterBuildingNumber {
    return Intl.message(
      'Enter building number',
      name: 'enterBuildingNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the building number`
  String get pleaseEnterBuildingNumber {
    return Intl.message(
      'Please enter the building number',
      name: 'pleaseEnterBuildingNumber',
      desc: '',
      args: [],
    );
  }

  /// `Choose a name for the address...`
  String get chooseAddressName {
    return Intl.message(
      'Choose a name for the address...',
      name: 'chooseAddressName',
      desc: '',
      args: [],
    );
  }

  /// `Next Step`
  String get nextStep {
    return Intl.message('Next Step', name: 'nextStep', desc: '', args: []);
  }

  /// `Data registered successfully`
  String get dataRegisteredSuccessfully {
    return Intl.message(
      'Data registered successfully',
      name: 'dataRegisteredSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `You can now apply for various government services available through the platform.`
  String get youCanNowApply {
    return Intl.message(
      'You can now apply for various government services available through the platform.',
      name: 'youCanNowApply',
      desc: '',
      args: [],
    );
  }

  /// `View Available Services`
  String get viewAvailableServices {
    return Intl.message(
      'View Available Services',
      name: 'viewAvailableServices',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Search in your requests`
  String get searchInYourRequests {
    return Intl.message(
      'Search in your requests',
      name: 'searchInYourRequests',
      desc: '',
      args: [],
    );
  }

  /// `Completed Requests`
  String get completedRequests {
    return Intl.message(
      'Completed Requests',
      name: 'completedRequests',
      desc: '',
      args: [],
    );
  }

  /// `Ongoing Requests`
  String get ongoingRequests {
    return Intl.message(
      'Ongoing Requests',
      name: 'ongoingRequests',
      desc: '',
      args: [],
    );
  }

  /// `Complete Data`
  String get completeData {
    return Intl.message(
      'Complete Data',
      name: 'completeData',
      desc: '',
      args: [],
    );
  }

  /// `Request Details`
  String get requestDetails {
    return Intl.message(
      'Request Details',
      name: 'requestDetails',
      desc: '',
      args: [],
    );
  }

  /// `Learn more about your request status`
  String get learnMoreAboutRequestStatus {
    return Intl.message(
      'Learn more about your request status',
      name: 'learnMoreAboutRequestStatus',
      desc: '',
      args: [],
    );
  }

  /// `Attached Documents`
  String get attachedDocuments {
    return Intl.message(
      'Attached Documents',
      name: 'attachedDocuments',
      desc: '',
      args: [],
    );
  }

  /// `Please re-enter the required data and submit the request`
  String get pleaseReenterDataAndSubmit {
    return Intl.message(
      'Please re-enter the required data and submit the request',
      name: 'pleaseReenterDataAndSubmit',
      desc: '',
      args: [],
    );
  }

  /// `Some unclear or incorrect data was found in your request. Please review the following notes and resend the request to continue.`
  String get unclearOrIncorrectDataFound {
    return Intl.message(
      'Some unclear or incorrect data was found in your request. Please review the following notes and resend the request to continue.',
      name: 'unclearOrIncorrectDataFound',
      desc: '',
      args: [],
    );
  }

  /// `Please complete the following data`
  String get pleaseCompleteTheFollowingData {
    return Intl.message(
      'Please complete the following data',
      name: 'pleaseCompleteTheFollowingData',
      desc: '',
      args: [],
    );
  }

  /// `Service application form`
  String get serviceApplicationForm {
    return Intl.message(
      'Service application form',
      name: 'serviceApplicationForm',
      desc: '',
      args: [],
    );
  }

  /// `Please fill in the data carefully to facilitate the application review.`
  String get serviceApplicationFormDescription {
    return Intl.message(
      'Please fill in the data carefully to facilitate the application review.',
      name: 'serviceApplicationFormDescription',
      desc: '',
      args: [],
    );
  }

  /// `Hello, {name}`
  String greetingUser(Object name) {
    return Intl.message(
      'Hello, $name',
      name: 'greetingUser',
      desc: '',
      args: [name],
    );
  }

  /// `Available Services`
  String get availableServices {
    return Intl.message(
      'Available Services',
      name: 'availableServices',
      desc: '',
      args: [],
    );
  }

  /// `Your Requests`
  String get yourRequests {
    return Intl.message(
      'Your Requests',
      name: 'yourRequests',
      desc: '',
      args: [],
    );
  }

  /// `News and Announcements`
  String get newsAndAnnouncements {
    return Intl.message(
      'News and Announcements',
      name: 'newsAndAnnouncements',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Edit Emergency Numbers`
  String get editEmergencyNumbers {
    return Intl.message(
      'Edit Emergency Numbers',
      name: 'editEmergencyNumbers',
      desc: '',
      args: [],
    );
  }

  /// `Emergency numbers are saved in your phone wallet for quick access to relatives in case of emergency.`
  String get emergencyNumbersInfo {
    return Intl.message(
      'Emergency numbers are saved in your phone wallet for quick access to relatives in case of emergency.',
      name: 'emergencyNumbersInfo',
      desc: '',
      args: [],
    );
  }

  /// `Emergency Numbers`
  String get emergencyNumbers {
    return Intl.message(
      'Emergency Numbers',
      name: 'emergencyNumbers',
      desc: '',
      args: [],
    );
  }

  /// `Father`
  String get father {
    return Intl.message('Father', name: 'father', desc: '', args: []);
  }

  /// `Brother`
  String get brother {
    return Intl.message('Brother', name: 'brother', desc: '', args: []);
  }

  /// `Contact name...`
  String get contactNamePlaceholder {
    return Intl.message(
      'Contact name...',
      name: 'contactNamePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Save Changes`
  String get saveChanges {
    return Intl.message(
      'Save Changes',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `Please include the following attachments. Providing as many optional documents as possible may expedite the application process.`
  String get attechedFileDescription {
    return Intl.message(
      'Please include the following attachments. Providing as many optional documents as possible may expedite the application process.',
      name: 'attechedFileDescription',
      desc: '',
      args: [],
    );
  }

  /// `Back to your requests`
  String get backToYourRequests {
    return Intl.message(
      'Back to your requests',
      name: 'backToYourRequests',
      desc: '',
      args: [],
    );
  }

  /// `send again`
  String get sendAgain {
    return Intl.message('send again', name: 'sendAgain', desc: '', args: []);
  }

  /// `We were unable to receive your request.`
  String get weWereUnableToReceiveYourRequest {
    return Intl.message(
      'We were unable to receive your request.',
      name: 'weWereUnableToReceiveYourRequest',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, there seems to be a technical issue with our servers. Your request has been saved as a draft. Please try submitting later.`
  String get faliarDes {
    return Intl.message(
      'Sorry, there seems to be a technical issue with our servers. Your request has been saved as a draft. Please try submitting later.',
      name: 'faliarDes',
      desc: '',
      args: [],
    );
  }

  /// `Available Services Page`
  String get servicesPageTitle {
    return Intl.message(
      'Available Services Page',
      name: 'servicesPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `A page displaying all available services on the platform | Currently 60 services`
  String get servicesPageDescription {
    return Intl.message(
      'A page displaying all available services on the platform | Currently 60 services',
      name: 'servicesPageDescription',
      desc: '',
      args: [],
    );
  }

  /// `Search for a service`
  String get searchForService {
    return Intl.message(
      'Search for a service',
      name: 'searchForService',
      desc: '',
      args: [],
    );
  }

  /// `Community Care`
  String get communityCare {
    return Intl.message(
      'Community Care',
      name: 'communityCare',
      desc: '',
      args: [],
    );
  }

  /// `Family Empowerment`
  String get familyEmpowerment {
    return Intl.message(
      'Family Empowerment',
      name: 'familyEmpowerment',
      desc: '',
      args: [],
    );
  }

  /// `Associations and Private Institutions`
  String get associationsAndPrivateInstitutions {
    return Intl.message(
      'Associations and Private Institutions',
      name: 'associationsAndPrivateInstitutions',
      desc: '',
      args: [],
    );
  }

  /// `Citizen Housing`
  String get citizenHousing {
    return Intl.message(
      'Citizen Housing',
      name: 'citizenHousing',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `Apply for Social Security Service`
  String get applySocialSecurity {
    return Intl.message(
      'Apply for Social Security Service',
      name: 'applySocialSecurity',
      desc: '',
      args: [],
    );
  }

  /// `This service allows requesting a social security pension for the following categories: widow, divorced woman, needy family, disabled person, orphan, person unable to work, elderly, prisoner’s family, abandoned wife, and deceased’s family, as well as domestic helper allowance. Cabinet Decision No. (46) of 2014 specifies the pension amount for the categories listed in Law No. (38) of 1995 on Social Security and its granting rules.`
  String get applySocialSecurityDescription {
    return Intl.message(
      'This service allows requesting a social security pension for the following categories: widow, divorced woman, needy family, disabled person, orphan, person unable to work, elderly, prisoner’s family, abandoned wife, and deceased’s family, as well as domestic helper allowance. Cabinet Decision No. (46) of 2014 specifies the pension amount for the categories listed in Law No. (38) of 1995 on Social Security and its granting rules.',
      name: 'applySocialSecurityDescription',
      desc: '',
      args: [],
    );
  }

  /// `Apply for Financial Aid`
  String get applyFinancialAid {
    return Intl.message(
      'Apply for Financial Aid',
      name: 'applyFinancialAid',
      desc: '',
      args: [],
    );
  }

  /// `This service allows individuals and needy families to apply for financial assistance to cover their basic needs, such as food, shelter, and healthcare. These aids aim to support families affected by economic crises or natural disasters. The executive regulations define the conditions and application procedures.`
  String get applyFinancialAidDescription {
    return Intl.message(
      'This service allows individuals and needy families to apply for financial assistance to cover their basic needs, such as food, shelter, and healthcare. These aids aim to support families affected by economic crises or natural disasters. The executive regulations define the conditions and application procedures.',
      name: 'applyFinancialAidDescription',
      desc: '',
      args: [],
    );
  }

  /// `Apply for Free Healthcare`
  String get applyHealthcare {
    return Intl.message(
      'Apply for Free Healthcare',
      name: 'applyHealthcare',
      desc: '',
      args: [],
    );
  }

  /// `This service allows poor citizens to apply for free healthcare, ensuring they receive necessary medical treatment and services without any costs. This includes medical checkups, medications, and treatment in public hospitals. This service comes as part of comprehensive social care.`
  String get applyHealthcareDescription {
    return Intl.message(
      'This service allows poor citizens to apply for free healthcare, ensuring they receive necessary medical treatment and services without any costs. This includes medical checkups, medications, and treatment in public hospitals. This service comes as part of comprehensive social care.',
      name: 'applyHealthcareDescription',
      desc: '',
      args: [],
    );
  }

  /// `Apply for Educational Support`
  String get applyEducationalSupport {
    return Intl.message(
      'Apply for Educational Support',
      name: 'applyEducationalSupport',
      desc: '',
      args: [],
    );
  }

  /// `This service allows students from low-income families to apply for financial support to cover educational expenses, including tuition fees, textbooks, and educational materials. This initiative aims to promote affordable education opportunities for all and achieve educational equity.`
  String get applyEducationalSupportDescription {
    return Intl.message(
      'This service allows students from low-income families to apply for financial support to cover educational expenses, including tuition fees, textbooks, and educational materials. This initiative aims to promote affordable education opportunities for all and achieve educational equity.',
      name: 'applyEducationalSupportDescription',
      desc: '',
      args: [],
    );
  }

  /// `Courses`
  String get coursesTitle {
    return Intl.message('Courses', name: 'coursesTitle', desc: '', args: []);
  }

  /// `Courses`
  String get courses {
    return Intl.message('Courses', name: 'courses', desc: '', args: []);
  }

  /// `No courses available`
  String get noCourses {
    return Intl.message(
      'No courses available',
      name: 'noCourses',
      desc: '',
      args: [],
    );
  }

  /// `Loading courses...`
  String get coursesLoading {
    return Intl.message(
      'Loading courses...',
      name: 'coursesLoading',
      desc: '',
      args: [],
    );
  }

  /// `Continue Watching`
  String get continueWatching {
    return Intl.message(
      'Continue Watching',
      name: 'continueWatching',
      desc: '',
      args: [],
    );
  }

  /// `Error loading courses`
  String get errorLoadingCourses {
    return Intl.message(
      'Error loading courses',
      name: 'errorLoadingCourses',
      desc: '',
      args: [],
    );
  }

  /// `Lessons`
  String get lessons {
    return Intl.message('Lessons', name: 'lessons', desc: '', args: []);
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `Course Details`
  String get courseDetails {
    return Intl.message(
      'Course Details',
      name: 'courseDetails',
      desc: '',
      args: [],
    );
  }

  /// `Error loading course details`
  String get errorLoadingCourse {
    return Intl.message(
      'Error loading course details',
      name: 'errorLoadingCourse',
      desc: '',
      args: [],
    );
  }

  /// `Error loading lesson`
  String get errorLoadingLesson {
    return Intl.message(
      'Error loading lesson',
      name: 'errorLoadingLesson',
      desc: '',
      args: [],
    );
  }

  /// `No lessons available`
  String get noLessons {
    return Intl.message(
      'No lessons available',
      name: 'noLessons',
      desc: '',
      args: [],
    );
  }

  /// `Progress`
  String get progress {
    return Intl.message('Progress', name: 'progress', desc: '', args: []);
  }

  /// `Completed`
  String get completed {
    return Intl.message('Completed', name: 'completed', desc: '', args: []);
  }

  /// `In Progress`
  String get inProgress {
    return Intl.message('In Progress', name: 'inProgress', desc: '', args: []);
  }

  /// `In Progress`
  String get statusInProgress {
    return Intl.message(
      'In Progress',
      name: 'statusInProgress',
      desc: '',
      args: [],
    );
  }

  /// `Not Started`
  String get notStarted {
    return Intl.message('Not Started', name: 'notStarted', desc: '', args: []);
  }

  /// `Please complete previous lessons first`
  String get lessonLocked {
    return Intl.message(
      'Please complete previous lessons first',
      name: 'lessonLocked',
      desc: '',
      args: [],
    );
  }

  /// `Locked`
  String get locked {
    return Intl.message('Locked', name: 'locked', desc: '', args: []);
  }

  /// `Unlocked`
  String get unlocked {
    return Intl.message('Unlocked', name: 'unlocked', desc: '', args: []);
  }

  /// `Instructor`
  String get instructor {
    return Intl.message('Instructor', name: 'instructor', desc: '', args: []);
  }

  /// `Sections`
  String get sections {
    return Intl.message('Sections', name: 'sections', desc: '', args: []);
  }

  /// `Error loading video`
  String get videoLoadError {
    return Intl.message(
      'Error loading video',
      name: 'videoLoadError',
      desc: '',
      args: [],
    );
  }

  /// `Next lesson`
  String get nextLesson {
    return Intl.message('Next lesson', name: 'nextLesson', desc: '', args: []);
  }

  /// `Previous lesson`
  String get previousLesson {
    return Intl.message(
      'Previous lesson',
      name: 'previousLesson',
      desc: '',
      args: [],
    );
  }

  /// `Playback Speed`
  String get playbackSpeed {
    return Intl.message(
      'Playback Speed',
      name: 'playbackSpeed',
      desc: '',
      args: [],
    );
  }

  /// `Normal`
  String get normalSpeed {
    return Intl.message('Normal', name: 'normalSpeed', desc: '', args: []);
  }

  /// `Speed`
  String get speed {
    return Intl.message('Speed', name: 'speed', desc: '', args: []);
  }

  /// `Play`
  String get play {
    return Intl.message('Play', name: 'play', desc: '', args: []);
  }

  /// `Pause`
  String get pause {
    return Intl.message('Pause', name: 'pause', desc: '', args: []);
  }

  /// `Replay`
  String get replay {
    return Intl.message('Replay', name: 'replay', desc: '', args: []);
  }

  /// `Fullscreen`
  String get fullscreen {
    return Intl.message('Fullscreen', name: 'fullscreen', desc: '', args: []);
  }

  /// `Exit Fullscreen`
  String get exitFullscreen {
    return Intl.message(
      'Exit Fullscreen',
      name: 'exitFullscreen',
      desc: '',
      args: [],
    );
  }

  /// `Duration`
  String get duration {
    return Intl.message('Duration', name: 'duration', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Arabic`
  String get arabic {
    return Intl.message('Arabic', name: 'arabic', desc: '', args: []);
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Theme`
  String get theme {
    return Intl.message('Theme', name: 'theme', desc: '', args: []);
  }

  /// `Light Mode`
  String get lightMode {
    return Intl.message('Light Mode', name: 'lightMode', desc: '', args: []);
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message('Dark Mode', name: 'darkMode', desc: '', args: []);
  }

  /// `Close`
  String get close {
    return Intl.message('Close', name: 'close', desc: '', args: []);
  }

  /// `Search courses or instructors...`
  String get searchCourses {
    return Intl.message(
      'Search courses or instructors...',
      name: 'searchCourses',
      desc: '',
      args: [],
    );
  }

  /// `No courses found`
  String get noCoursesFound {
    return Intl.message(
      'No courses found',
      name: 'noCoursesFound',
      desc: '',
      args: [],
    );
  }

  /// `Clear search`
  String get clearSearch {
    return Intl.message(
      'Clear search',
      name: 'clearSearch',
      desc: '',
      args: [],
    );
  }

  /// `Lesson Notes`
  String get lessonNotes {
    return Intl.message(
      'Lesson Notes',
      name: 'lessonNotes',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get notes {
    return Intl.message('Notes', name: 'notes', desc: '', args: []);
  }

  /// `Write your thoughts or notes here...`
  String get addNote {
    return Intl.message(
      'Write your thoughts or notes here...',
      name: 'addNote',
      desc: '',
      args: [],
    );
  }

  /// `Save Note`
  String get saveNote {
    return Intl.message('Save Note', name: 'saveNote', desc: '', args: []);
  }

  /// `Note saved successfully`
  String get noteSaved {
    return Intl.message(
      'Note saved successfully',
      name: 'noteSaved',
      desc: '',
      args: [],
    );
  }

  /// `Delete Note`
  String get deleteNote {
    return Intl.message('Delete Note', name: 'deleteNote', desc: '', args: []);
  }

  /// `Note deleted`
  String get noteDeleted {
    return Intl.message(
      'Note deleted',
      name: 'noteDeleted',
      desc: '',
      args: [],
    );
  }

  /// `No notes yet for this lesson`
  String get noNotesYet {
    return Intl.message(
      'No notes yet for this lesson',
      name: 'noNotesYet',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
