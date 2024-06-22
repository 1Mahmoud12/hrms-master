import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cnattendance/Controller/StaticControllers/mainBlocHome/cubit.dart';
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
import 'package:cnattendance/screen/Chat/presentation/mainager/supportCustomerBloc/cubit.dart';
import 'package:cnattendance/screen/Chat/presentation/mainager/view/chatCustomer/chat_customer.dart';
import 'package:cnattendance/screen/Chat/presentation/mainager/view/chatCustomer/messages_customer_screen.dart';
import 'package:cnattendance/screen/addElevator/presentation/manager/mainBlocElevator/cubit.dart';
import 'package:cnattendance/screen/addMaintenance/presentation/manager/mainBlocMaintenanceContract/cubit.dart';
import 'package:cnattendance/screen/addMaintenance/presentation/view/add_maintenance_contract.dart';
import 'package:cnattendance/screen/auth/view/manager/login/cubit.dart';
import 'package:cnattendance/screen/auth/view/presentation/login_screen.dart';
import 'package:cnattendance/screen/dashboard/bottommenu/bottommenu.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/commentBLoc/cubit.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/overViewProjectBloc/cubit.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/paymentBloc/cubit.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/progressBloc/cubit.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/tasksBloc/cubit.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/view/all_project_details.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/view/proposal/all_proposal.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/view/tasksScreen/add_tasks_screen.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/view/tasksScreen/edit_tasks.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/view/tasksScreen/tasks_screen.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/view/widgets/edit_progress.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/view/widgets/payment_screen.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/view/widgets/progress_screen.dart';
import 'package:cnattendance/screen/employer/home_dashboard_screen.dart';
import 'package:cnattendance/screen/employer/main_screen_employer/manager/maniBloc/cubit.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/emergencieBloc/cubit/emergencie_cubit.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/reportBloc/cubit.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/widgets/all_details_report.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/widgets/edit_report_screen.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/widgets/emergency_screen_items.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/widgets/periodic_maintenance_screen_item.dart';
import 'package:cnattendance/screen/profile/editprofilescreen.dart';
import 'package:cnattendance/screen/profile/meetingdetailscreen.dart';
import 'package:cnattendance/screen/profile/payslipdetailscreen.dart';
import 'package:cnattendance/screen/profile/profilescreen.dart';
import 'package:cnattendance/screen/splashscreen.dart';
import 'package:cnattendance/utils/navigationservice.dart';
import 'package:cnattendance/utils/notification_utility.dart';
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

import 'screen/addElevator/presentation/view/add_elevator.dart';
import 'screen/employer/allProject/presentation/view/proposal/details_porposal_screen.dart';
import 'screen/employer/allProject/presentation/view/widgets/add_progress_screen.dart';
import 'screen/employer/allProject/presentation/view/widgets/details_contract_project.dart';
import 'screen/employer/allProject/presentation/view/widgets/team_project_screen.dart';
import 'screen/employer/main_screen_employer/presentation/view/widgets/know_us.dart';
import 'screen/employer/maintenance/presentation/manager/mainBlocMaintenance/cubit.dart';
import 'screen/employer/maintenance/presentation/manager/productsNeedBloc/cubit.dart';
import 'screen/employer/maintenance/presentation/view/emergency_malfunction_screen.dart';
import 'screen/employer/maintenance/presentation/view/widgets/all_details_elevator.dart';
import 'screen/employer/maintenance/presentation/view/widgets/details_maintenance_report.dart';
import 'screen/employer/maintenance/presentation/view/widgets/details_maintenance_widget.dart';
import 'screen/employer/maintenance/presentation/view/widgets/maintenance_report_mechanics.dart';
import 'screen/employer/maintenance/presentation/view/widgets/maintenance_report_technical.dart';
import 'screen/employer/maintenance/presentation/view/widgets/payment_maintenance_value.dart';
import 'utils/Language/language.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    notificationMethod();
    // TODO: implement initState
    AwesomeNotifications().setListeners(onActionReceivedMethod: NotificationUtility.onActionReceivedMethod);
    super.initState();
  }

  Future<void> notificationMethod() async {
    final NotificationSettings settings = await FirebaseMessaging.instance.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else {
      debugPrint('User declined or has not accepted permission');
    }

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
              create: (context) => OverViewProjectCubit(),
            ),
            BlocProvider(
              create: (context) => MainBlocMaintenanceContractCubit(),
            ),
            BlocProvider(
              create: (context) => MainBlocElevatorCubit(),
            ),
            BlocProvider(
              create: (context) => MainBlocHomeCubit(),
            ),
            BlocProvider(
              create: (context) => ProgressCubit(),
            ),
            BlocProvider(
              create: (context) => ProductsNeedBloc(),
            ),
            BlocProvider(
              create: (context) => ReportBloc(),
            ),
            BlocProvider(
              create: (context) => SupportCustomerBloc(),
            ),
            BlocProvider(
              create: (context) => PaymentCubit(),
            ),
            BlocProvider(
              create: (context) => CommentCubit(),
            ),
            BlocProvider(
              create: (context) => TasksCubit(),
            ),
               BlocProvider(
              create: (context) => EmergencieCubit(),
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
                  useInheritedMediaQuery: true,
                  builder: EasyLoading.init(),

                  //builder: DevicePreview.appBuilder,
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
                    HomeDashboardScreen.routeName: (_) => const HomeDashboardScreen(),
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
                    AppRoute.emergencyMalfunctionScreen: (_) => const EmergencyMalfunctionScreen(),
                    AppRoute.maintenanceReportMechanics: (_) => const MaintenanceReportMechanics(),
                    AppRoute.maintenanceReportTechnical: (_) => const MaintenanceReportTechnical(),
                    AppRoute.detailsContractProject: (_) => const DetailsContractProject(),
                    AppRoute.addElevator: (_) => const AddElevator(),
                    AppRoute.payments: (_) => const PaymentScreen(),
                    AppRoute.addMaintenanceContract: (_) => const AddMaintenanceContract(),
                    AppRoute.teamProjectScreen: (_) => const TeamProjectScreen(),
                    AppRoute.addProgressScreen: (_) => const AddProgressScreen(),
                    AppRoute.editProgressScreen: (_) => const EditProgressScreen(),
                    AppRoute.tasksScreen: (_) => const TasksScreen(),
                    AppRoute.proposalScreen: (_) => const ProposalScreen(),
                    AppRoute.detailsProposalScreen: (_) => const DetailsProposalScreen(),
                    AppRoute.addTasksScreen: (_) => const AddTasksScreen(),
                    AppRoute.editTasksScreen: (_) => const EditTasksScreen(),
                    AppRoute.editReportScreen: (_) => const EditReportScreen(),
                    AppRoute.chatCustomer: (_) => const ChatCustomer(),
                    AppRoute.messagesCustomerScreen: (_) => const MessagesCustomerScreen(),
                    AppRoute.periodicMaintenanceScreenItems: (_) => const PeriodicMaintenanceScreenItems(),
                    AppRoute.emergencyScreenItems: (_) => const EmergencyScreenItems(),
                    ProfileScreen.routeName: (_) => const ProfileScreen(),
                    EditProfileScreen.routeName: (_) => const EditProfileScreen(),
                    MeetingDetailScreen.routeName: (_) => const MeetingDetailScreen(),
                    PaySlipDetailScreen.routeName: (_) => const PaySlipDetailScreen(),
                    MenuScreen.routeName: (_) => MenuScreen(),
                  },
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
