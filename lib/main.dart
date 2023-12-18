import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cnattendance/core/routes/app_route.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/model/auth.dart';
import 'package:cnattendance/provider/attendancereportprovider.dart';
import 'package:cnattendance/provider/dashboardprovider.dart';
import 'package:cnattendance/provider/leaveprovider.dart';
import 'package:cnattendance/provider/meetingprovider.dart';
import 'package:cnattendance/provider/morescreenprovider.dart';
import 'package:cnattendance/provider/payslipprovider.dart';
import 'package:cnattendance/provider/prefprovider.dart';
import 'package:cnattendance/provider/profileprovider.dart';
import 'package:cnattendance/provider/requestleaveprovider.dart';
import 'package:cnattendance/provider/requestpaidprovider.dart';
import 'package:cnattendance/screen/addElevator/presentation/manager/mainBlocElevator/cubit.dart';
import 'package:cnattendance/screen/addMaintenance/presentation/manager/mainBlocMaintenanceContract/cubit.dart';
import 'package:cnattendance/screen/addMaintenance/presentation/view/add_maintenance_contract.dart';
import 'package:cnattendance/screen/auth/view/manager/login/cubit.dart';
import 'package:cnattendance/screen/auth/view/presentation/login_screen.dart';
import 'package:cnattendance/screen/dashboard/bottommenu/bottommenu.dart';
import 'package:cnattendance/screen/employer/ProjectsScreen/home_dashboard_screen.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/view/all_project_details.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/view/widgets/progress_screen.dart';
import 'package:cnattendance/screen/employer/main_screen_employer/manager/maniBloc/cubit.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/widgets/all_details_report.dart';
import 'package:cnattendance/screen/profile/editprofilescreen.dart';
import 'package:cnattendance/screen/profile/meetingdetailscreen.dart';
import 'package:cnattendance/screen/profile/payslipdetailscreen.dart';
import 'package:cnattendance/screen/profile/profilescreen.dart';
import 'package:cnattendance/screen/splashscreen.dart';
import 'package:cnattendance/utils/navigationservice.dart';
import 'package:cnattendance/utils/notification_utility.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:in_app_notification/in_app_notification.dart';
import 'package:provider/provider.dart';

import 'core/utils/constants.dart';
import 'screen/addElevator/presentation/view/add_elevator.dart';
import 'screen/employer/allProject/presentation/view/widgets/details_contract_project.dart';
import 'screen/employer/main_screen_employer/presentation/view/widgets/know_us.dart';
import 'screen/employer/maintenance/presentation/manager/mainBlocMaintenance/cubit.dart';
import 'screen/employer/maintenance/presentation/view/widgets/all_details_elevator.dart';
import 'screen/employer/maintenance/presentation/view/widgets/details_maintenance_report.dart';
import 'screen/employer/maintenance/presentation/view/widgets/details_maintenance_widget.dart';
import 'screen/employer/maintenance/presentation/view/widgets/payment_maintenance_value.dart';
import 'utils/Language/language.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /*SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: AppColors.scaffoldBackGround, // Change this to your desired color
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark),
  );*/
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCvg-9ixi6qW3GVEa5e4T6owkIlQ0bPKIo',
      appId: '1:10784846687:android:0399a73ffa4a398d9e3cea',
      messagingSenderId: '10784846687',
      projectId: 'rakelvator',
      storageBucket: 'rakelvator.appspot.com',
    ),
  );

  FirebaseMessaging.onBackgroundMessage(_messageHandler);

  // Step required to send ios push notification
  final NotificationSettings settings = await FirebaseMessaging.instance.requestPermission();

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    debugPrint('User granted permission');
  } else {
    debugPrint('User declined or has not accepted permission');
  }
  fcmToken = await FirebaseMessaging.instance.getToken() ?? '';
  debugPrint('fcm $fcmToken');
  await Preferences.init();

  await NotificationUtility.initializeAwesomeNotification();

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      // This is just a basic example. For real apps, you must show some
      // friendly dialog box before call the request method.
      // This is very important to not harm the user experience
      // AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  FirebaseMessaging.onMessage.listen((event) {
    FlutterRingtonePlayer.play(
      fromAsset: 'assets/sound/beep.mp3',
    );
    try {
      InAppNotification.show(
        child: Card(
          margin: const EdgeInsets.all(15),
          child: ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            leading: const SizedBox(height: double.infinity, child: Icon(Icons.notifications)),
            iconColor: const Color(0xff011754),
            textColor: const Color(0xff011754),
            minVerticalPadding: 10,
            minLeadingWidth: 0,
            tileColor: Colors.white,
            title: Text(
              event.notification!.title!,
            ),
            subtitle: Text(
              event.notification!.body!,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
        context: NavigationService.navigatorKey.currentState!.context,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    debugPrint('Message clicked!');
  });

  final ByteData data = await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());

  runApp(const MyApp());
  configLoading();
}

Future<void> _messageHandler(RemoteMessage message) async {
  FlutterRingtonePlayer.play(
    fromAsset: 'assets/sound/beep.mp3',
  );
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.cubeGrid
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 50.0
    ..radius = 0.0
    ..progressColor = Colors.blue
    ..backgroundColor = Colors.white
    ..indicatorColor = Colors.blue
    ..textColor = Colors.black
    ..maskType = EasyLoadingMaskType.none
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
    AwesomeNotifications().setListeners(onActionReceivedMethod: NotificationUtility.onActionReceivedMethod);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => Auth(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => Preferences(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => LeaveProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => RequestProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => RequestPaidProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => CustomerProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => ProfileProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => AttendanceReportProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => DashboardProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => MoreScreenProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => MeetingProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => PaySlipProvider(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => MainBlocHomeCustomerCubit(),
            ),
            BlocProvider(
              create: (context) => MainBlocMaintenanceCubit(),
            ),
            BlocProvider(
              create: (context) => LoginCubit(),
            ),
            BlocProvider(
              create: (context) => MainBlocMaintenanceContractCubit(),
            ),
            BlocProvider(
              create: (context) => MainBlocElevatorCubit(),
            ),
          ],
          child: Portal(
            child: InAppNotification(
              child: GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                onVerticalDragDown: (details) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: GetMaterialApp(
                  locale: const Locale('en', 'US'),
                  translations: Language(),
                  navigatorKey: NavigationService.navigatorKey,
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    useMaterial3: true,
                    canvasColor: const Color.fromRGBO(255, 255, 255, 1),
                    fontFamily: 'Urbanist',
                    primarySwatch: Colors.blue,
                    scaffoldBackgroundColor: AppColors.scaffoldBackGround,
                    appBarTheme: const AppBarTheme(
                      backgroundColor: Colors.transparent,
                      centerTitle: true,
                      iconTheme: IconThemeData(color: Colors.black),
                      elevation: 0,
                      // brightness: Brightness.light,
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.black,
                        statusBarIconBrightness: Brightness.light,
                      ),
                      // titleTextStyle: Styles.styleHeader,
                    ),
                  ),
                  initialRoute: '/',
                  routes: {
                    '/': (_) => const SplashScreen(),
                    HomeDashboardScreen.routeName: (_) => HomeDashboardScreen(),
                    LoginScreen.routeName: (_) => const LoginScreen(),
                    // AppRoute.dashboardScreen: (_) => DashboardScreen(),
                    AppRoute.cardDetailsProject: (_) => const AllProjectDetails(),
                    AppRoute.knowUs: (_) => const KnowUs(),
                    AppRoute.detailsMaintenanceWidget: (_) => const DetailsMaintenanceWidget(),
                    //  AppRoute.detailsElevators: (_) => const DetailsElevators(),
                    AppRoute.progressScreen: (_) => const ProgressScreen(),
                    AppRoute.allDetailsElevator: (_) => const AllDetailsElevator(),
                    AppRoute.detailsMaintenance: (_) => const DetailsMaintenance(),
                    AppRoute.paymentMaintenanceValue: (_) => const PaymentMaintenanceValue(),
                    AppRoute.allDetailsReport: (_) => const AllDetailsReport(),
                    AppRoute.detailsContractProject: (_) => const DetailsContractProject(),
                    AppRoute.addElevator: (_) => const AddElevator(),
                    AppRoute.addMaintenanceContract: (_) => const AddMaintenanceContract(),
                    ProfileScreen.routeName: (_) => const ProfileScreen(),
                    EditProfileScreen.routeName: (_) => const EditProfileScreen(),
                    MeetingDetailScreen.routeName: (_) => const MeetingDetailScreen(),
                    PaySlipDetailScreen.routeName: (_) => const PaySlipDetailScreen(),
                    MenuScreen.routeName: (_) => MenuScreen(),
                  },
                  builder: EasyLoading.init(),
                  // home: const AddElevator(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
