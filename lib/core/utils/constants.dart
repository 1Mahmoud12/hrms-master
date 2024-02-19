import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/screen/auth/data/model/login_model.dart';
import 'package:cnattendance/screen/employer/allProject/data/models/all_proposals_model.dart';
import 'package:cnattendance/screen/employer/maintenance/data/model/periodic_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

LatLng cairoLatLng = const LatLng(30.033333, 31.233334);
String locationCache = '';
String fcmToken = '';
String tokenCache =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZTI5YzkwYTlkOTlmODA0Y2Q2YjFmZWEzYTgyMDAyNTEwOTBjYjU2ZTdkYzcyMzNhNmE4MDRmZTQ0NThiODU2NjNjMjE4M2U2NDg4N2NmNzMiLCJpYXQiOjE3MDgxMjA3NTIuNTExNTM5LCJuYmYiOjE3MDgxMjA3NTIuNTExNTQsImV4cCI6MTczOTc0MzE1Mi41MTA5MTksInN1YiI6IjYyIiwic2NvcGVzIjpbXX0.GjegBTIFctqocgFERFdQa2CNU1QXU5400r4qQ02gUxbRe5VZtAMy4SEWCCGEz52zimeL8pW3oOGAIDsoCG0-0wCe9BPpSQanFMPNMBaArAp1QRC7M_RKmH9mhgRy7XDUAHBiNvXWK6edWj6t6nLSYv3vDOt2BP1bjhV0Fs7FTHaYfpNOe1OhvCR5ZLDYZ3lnrUAaKFOGFFgnWYDBReghX-LY5eq9c17AGX-M9UVA9EelXpSzSkXw7G-8KpDjcXB7yg4YPvKbCeLLYGmWPYLqgov6N27zmQ-_Oghfjbx4LZlhK6XG-K6QODlv5ywQBKx9KFkZiqtkiRc1U7XYh5zU25hX9uFGfOKYY2SEswW9HavTSGrlLWRvrw3Lo_iYYzSr9XyHio68gAwMEFcP-44g-ff1Brwupml8qdHQ3DmgyZomUXwQ72piH8Nvufd4w_rKW7Uf_iS0ob1Ehte4ngp_nlVpHHG1MGltnJ9Xlyjsm5VtNtDm7OiT93UHyPPccVa1OUQ7Rsg7W4Z2fDcRjYIFT68cPD9gX0TctFu7bCQuv8TW5b9rxhNvKq6cMVWA3jS0Pb8KwjRQmw2UtiVbNJ-rnrU-ec_p69clVO2dAflKG8waK0CK0ElAePHdZcXnvO1LMDCpxIO1yCKI5RaDfWMn79Tsa29nbX-LxaFW1JuBcao';
String tokenCacheKey = 'tokenCacheKey';
Preferences preferencesConstants = Preferences();
User? userCache;
String userCacheKey = 'userCacheKey';

AllProposalsModel? allProposalsModelCache;
String allProposalsKey = 'allProposalsModel';

PeriodicModel? allPeridicsCache;
String allPeridicsKey = 'allPeridicsKey';

//// customer =eight , engineer =nine, technical = ten,////  sales= twelve,client =eleven,
enum RoleId { eight, nine, ten, eleven, twelve }

enum Malfunction { In_Progress, Pending, Finished }

String? genderUser;
String genderUserKey = 'genderUser';
