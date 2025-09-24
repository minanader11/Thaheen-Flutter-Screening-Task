// import 'package:base_project/core/get_it/dependecy_injection.dart';
// import 'package:base_project/features/available_service/view/screen/available_service_screen.dart';
// import 'package:base_project/features/citizen_information/view/screens/citizens_information_page.dart';
// import 'package:base_project/features/citizen_information/view/screens/complete_information_successfully_page.dart';
// import 'package:base_project/features/citizen_information/view/screens/welcoming_page.dart';
// import 'package:base_project/features/citizen_information/view_model/citizen_information_cubit.dart';
// import 'package:base_project/features/citizen_information/view_model/step_one_cubit/step_one_citizen_information_cubit.dart';
// import 'package:base_project/features/citizen_information/view_model/step_two_cubit/step_two_citizen_information_cubit.dart';
// import 'package:base_project/features/my_requests/view/screens/all_your_requests_page.dart';
// import 'package:base_project/features/my_requests/view/screens/complete_data_page.dart';
// import 'package:base_project/features/my_requests/view/screens/request_details_page.dart';
// import 'package:base_project/features/onboarding/view/screens/onboarding_page.dart';
// import 'package:base_project/features/onboarding/view_model/onboarding_cubit.dart';
// import 'package:base_project/features/service_details/view/screen/service_details_screen.dart';
// import 'package:base_project/features/social_security/view/screen/social_security_screen.dart';
// import 'package:base_project/features/social_security/view/screen/edit_social_security_info.dart';
// import 'package:base_project/features/submit_service_request/view/screen/submit_service_request_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:base_project/core/routing/routes.dart';
//
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class AppRouter {
//   static Route generateRoute(RouteSettings settings) {
//     // final arguments = settings.arguments;
//     switch (settings.name) {
//       case Routes.onboarding:
//         return MaterialPageRoute(
//           builder: (_) => BlocProvider(
//             create: (context) => getIt<OnboardingCubit>(),
//             child: const OnboardingPage(),
//           ),
//         );
//       case Routes.login:
//         return MaterialPageRoute(
//           builder: (_) => const LoginScreen(),
//         );
//
//       case Routes.welcomingPage:
//         return MaterialPageRoute(
//           builder: (_) => const WelcomingPage(),
//         );
//
//       case Routes.citizensInformation:
//         return MaterialPageRoute(
//           builder: (_) => MultiBlocProvider(
//             providers: [
//               BlocProvider(
//                 create: (context) => getIt<CitizenInformationCubit>(),
//               ),
//               BlocProvider(
//                 create: (context) => getIt<StepOneCitizenInformationCubit>(),
//               ),
//               BlocProvider(
//                 create: (context) => getIt<StepTwoCitizenInformationCubit>(),
//               ),
//             ],
//             child: const CitizensInformationPage(),
//           ),
//         );
//
//       case Routes.completeInformationSuccessfully:
//         return MaterialPageRoute(
//           builder: (_) => const CompleteInformationSuccessfullyPage(),
//         );
//
//       case Routes.home:
//         return MaterialPageRoute(
//           settings: const RouteSettings(name: Routes.home),
//           builder: (_) => HomeScreen(),
//         );
//       case Routes.serviceDetails:
//         return MaterialPageRoute(
//           builder: (_) => const ServiceDetailsScreen(),
//         );
//       // Add more routes here as needed
//       case Routes.submitServiceRequest:
//         return MaterialPageRoute(
//           builder: (_) => SubmitServiceRequestScreen(),
//         );
//       case Routes.socialSecurityScreen:
//         return MaterialPageRoute(
//           builder: (_) => const SocialSecurityScreen(),
//         );
//
//       case Routes.editSocialSecurityScreen:
//         return MaterialPageRoute(
//           builder: (_) => EditSocialSecurityInfo(),
//         );
//       case Routes.allYourRequests:
//         return MaterialPageRoute(
//           builder: (_) => AllYourRequestsPage(),
//         );
//
//       case Routes.requestDetails:
//         return MaterialPageRoute(
//           builder: (_) => const RequestDetailsPage(),
//         );
//
//       case Routes.completeData:
//         return MaterialPageRoute(
//           builder: (_) => const CompleteDataPage(),
//         );
//       case Routes.availableService:
//         return MaterialPageRoute(
//           builder: (_) => const AvailableServiceScreen(),
//         );
//       default:
//         return MaterialPageRoute(
//           builder: (_) => Scaffold(
//             body: Center(child: Text('No route defined for ${settings.name}')),
//           ),
//         );
//     }
//   }
// }
