import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

LatLng cairoLatLng = const LatLng(30.033333, 31.233334);
String locationCache = '';
String fcmToken = '';
Preferences preferencesConstants = Preferences();

enum RoleId { customer, mechanics, technical }

enum Malfunction { In_Progress, Pending, Finished }

String? genderUser;
