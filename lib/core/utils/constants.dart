import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/screen/auth/data/model/login_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

LatLng cairoLatLng = const LatLng(30.033333, 31.233334);
String locationCache = '';
String fcmToken = '';
Preferences preferencesConstants = Preferences();
User? userCache;

//// customer =eight , engineer =nine, technical = ten, sales= eleven,client =12,
enum RoleId { eight, nine, ten, eleven, twelve }

enum Malfunction { In_Progress, Pending, Finished }

String? genderUser;
