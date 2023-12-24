import 'package:cnattendance/Controller/StaticControllers/mainBlocHome/state.dart';
import 'package:cnattendance/screen/Chat/ChatScreenView.dart';
import 'package:cnattendance/screen/Chat/presentation/mainager/view/chatCustomer/chat_customer.dart';
import 'package:cnattendance/screen/MoreScreenEmployee/MoreScreenNew.dart';
import 'package:cnattendance/screen/dashboard/homescreen.dart';
import 'package:cnattendance/screen/employer/ProjectsScreen/projects_screen.dart';
import 'package:cnattendance/screen/employer/contactus/contactus_screen.dart';
import 'package:cnattendance/screen/employer/main_screen_employer/home_screen_employer.dart';
import 'package:cnattendance/screen/employer/main_screen_employer/presentation/view/widgets/know_us.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/maintenance_screen.dart';
import 'package:cnattendance/screen/employer/privacypolicy/privacypolicy_screen.dart';
import 'package:cnattendance/screen/employer/staticloginhome/staticloginhome_screen.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainBlocHomeCubit extends Cubit<MainBlocHomeState> {
  MainBlocHomeCubit() : super(MainBlocHomeInitial());

  static MainBlocHomeCubit of(BuildContext context) => BlocProvider.of<MainBlocHomeCubit>(context);

  void changeToCustomer() {
    screenList = screenListCustomer;
    emit(ChangeIndexState());
  }

  void changeToClient() {
    screenList = screenListClient;
    emit(ChangeIndexState());
  }

  void changeToEmployer() {
    screenList = [
      const HomeScreen(),
      const MaintenanceScreen(),
      ChatScreenView(),
      const ProjectsScreen(),
      const MoreScreenNew(),
    ];
    emit(ChangeIndexState());
  }

  List<String> iconList = [
    Assets.selectedHome,
    Assets.selectedMaintenance,
    Assets.selectedProjects,
    Assets.selectedMenu,
  ];
  List<Widget> screenListCustomer = [
    const HomeScreenEmployer(),
    const MaintenanceScreen(),
    const ChatCustomer(),
    const ProjectsScreen(),
    const MoreScreenNew(),
  ];

  List<Widget> screenListClient = [
    const HomeScreenEmployer(),
    const PrivacyPolicyScreen(),
    const ContactUsScreen(),
    const KnowUs(),
    const StaticLoginHomeScreen(),
  ];
  List<Widget> screenList = [
    const HomeScreen(),
    const MaintenanceScreen(),
    ChatScreenView(),
    const ProjectsScreen(),
    const MoreScreenNew(),
  ];

  // toggle switch
  int indexList = 0;

  void changeIndex({required int index}) {
    indexList = index;
    emit(ChangeIndexState());
  }
}
