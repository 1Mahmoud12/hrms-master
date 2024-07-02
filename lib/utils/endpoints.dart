import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EndPoints {
  static const production = 'https://rak.bytes-sa.com/';

  // http://127.0.0.1:8000/api/login

  /// Change value based on your need.
  static const MAIN_URL = production;

  static const API_URL = '${MAIN_URL}api';
  static const PRIVACY_POLICY_URL = '${MAIN_URL}privacy';

  static const loginUrl = '$API_URL/login';

  static const allProposals = '$API_URL/proposals';
  static const proposalSalesStore = '$API_URL/proposals/sales/store';
  static const proposalSalesUpdate = '$API_URL/proposals/sales/update';
  static const proposalEngineerStore = '$API_URL/proposals/engineer/store';
  static const proposalEngineerUpdate = '$API_URL/proposals/engineer/update';
  static const forgetPassword = '$API_URL/forget-password';


  static const getPeridics = '$API_URL/peridics';
  static const addPeridics = '$API_URL/peridics/add';
  static const getAllElevators = '$API_URL/peridics/elevators/';
  static const getOneElevator = '$API_URL/peridics/elevator/';
  static const getOneReport = '$API_URL/peridics/report/';
  static const getOneReportMalF = '$API_URL/malfunctions/report/';
  static const getOneReportEmerg = '$API_URL/emergencies/report/';
  static const getOneEmergencie = '$API_URL/emergencies/';
  static const getOneMalfunctions = '$API_URL/malfunctions/';
  static const getAllReports = '$API_URL/peridics/reports/';
  static const addReportMalF = '$API_URL/malfunctions/report/add';
  static const addReportEmerg = '$API_URL/emergencies/report/add';
  static const updateReport = '$API_URL/peridics/report/update/';
  static const getEmergencie = '$API_URL/emergencies';
  static const getMalfunction = '$API_URL/malfunctions';
  static const getPaymentMalfunction = '$API_URL/malfunctions/payment/';
  static const getPayment = '$API_URL/emergencies';
  static const addEmergencie = '$API_URL/emergencies/add';
  static const addMalfunction = '$API_URL/malfunctions/add';
  static const UpdateMalfunction = '$API_URL/malfunctions/update/';
  static const uploadMalfunctionPayment = '$API_URL/malfunctions/payment';
  static const addPayment = '$API_URL/emergencies/payment';
  //  static const getEmergencie = '$API_URL/emergencies';
  //  static const getPayment = '$API_URL/payments-projects-detail';
  //  static const addEmergencie = '$API_URL/emergencies/add';
  //  static const addPayment = '$API_URL/emergencies/payment';

  static const DEACTIVATE_URL = '$API_URL/users/deactive';
  static const SIGNUP_URL = '$API_URL/users/creating';
  static const LOGOUT_URL = '$API_URL/logout';
  static const DASHBOARD_URL = '$API_URL/dashboard/';
  static const CHECK_IN_URL = '$API_URL/employees/check-in';
  static const CHECK_OUT_URL = '$API_URL/employees/check-out';
  static const ATTENDANCE_REPORT_URL = '$API_URL/employees/attendance-detail';
  static const LEAVE_TYPE_URL = '$API_URL/leave-types';
  static const LEAVE_TYPE_DETAIL_URL =
      '$API_URL/leave-requests/employee-leave-requests';
  static const ISSUE_LEAVE = '$API_URL/leave-requests/store';
  static const CANCEL_LEAVE = '$API_URL/leave-requests/cancel';
  static const PROFILE_URL = '$API_URL/users/profile';
  static const EMPLOYEE_PROFILE_URL = '$API_URL/users/profile-detail';
  static const CONTENT_URL = '$API_URL/static-page-content';
  static const TEAM_SHEET_URL = '$API_URL/users/company/team-sheet';
  static const LEAVE_CALENDAR_API =
      '$API_URL/leave-requests/employee-leave-calendar';
  static const LEAVE_CALENDAR_BY_DAY_API =
      '$API_URL/leave-requests/employee-leave-list';
  static const HOLIDAYS_API = '$API_URL/holidays';
  static const CHANGE_PASSWORD_API = '$API_URL/users/change-password';
  static const RULES_API = '$API_URL/company-rules';
  static const EDIT_PROFILE_URL = '$API_URL/users/update-profile';
  static const NOTIFICATION_URL = '$API_URL/notifications';
  static const NOTICE_URL = '$API_URL/notices';
  static const MEETING_URL = '$API_URL/team-meetings';

  static const PROJECT_DASHBOARD_URL = '$API_URL/project-management-dashboard';
  static const updateProjectDeadlineUrl = '$API_URL/update-projects-deadline';
  static const updateProjectStatus = '$API_URL/update-projects-status';
  static const addProjectsAttachmentUrl = '$API_URL/add-projects-attacments';
  static const deleteProjectsAttachments =
      '$API_URL/delete-projects-attacments';
  static const PROJECT_LIST_URL = '$API_URL/assigned-projects-list';
  static const PROJECT_DETAIL_URL = '$API_URL/assigned-projects-detail';
  static const TASK_LIST_URL = '$API_URL/assigned-task-list';
  static const TASK_DETAIL_URL = '$API_URL/assigned-task-detail';
  static const createTasks = '$API_URL/task-create';
  static const editTasks = '$API_URL/task-update';
  static const deleteTasks = '$API_URL/task-delete';
  static const UPDATE_CHECKLIST_TOGGLE_URL =
      '$API_URL/assigned-task-checklist/toggle-status';
  static const UPDATE_TASK_TOGGLE_URL =
      '$API_URL/assigned-task-detail/change-status';
  static const EMPLOYEE_DETAIL_URL = '$API_URL/users/profile-detail';
  static const GET_COMMENT_URL = '$API_URL/assigned-task-comments';
  static const SAVE_COMMENT_URL = '$API_URL/assigned-task/comments/store';
  static const DELETE_COMMENT_URL = '$API_URL/assigned-task/comment/delete';
  static const DELETE_REPLY_URL = '$API_URL/assigned-task/reply/delete';

  static const TADA_LIST_URL = '$API_URL/employee/tada-lists';
  static const TADA_DETAIL_URL = '$API_URL/employee/tada-details';
  static const TADA_STORE_URL = '$API_URL/employee/tada/store';
  static const TADA_UPDATE_URL = '$API_URL/employee/tada/update';
  static const TADA_DELETE_ATTACHMENT_URL =
      '$API_URL/employee/tada/delete-attachment';

  static const SUPPORT_URL = '$API_URL/support/query-store';
  static const DEPARTMENT_LIST_URL = '$API_URL/support/department-lists';
  static const SUPPORT_LIST_URL = '$API_URL/support/get-user-query-lists';

  static const CHAT_ALL_USERS = '$API_URL/users/chat';

  // static const USER_REQUEST = "$API_URL/request-types";
  static const USER_REQUEST = '$API_URL/request-types?type=unpaid';
  static const USER_REQUEST_PAID = '$API_URL/request-types?type=paid';
  static const USER_REQUEST_STORE = '$API_URL/requests/store';
  static const USER_REQUEST_VIEW =
      '$API_URL/requests/employee-requests?type=unpaid';
  static const USER_REQUEST_VIEW_PAID =
      '$API_URL/requests/employee-requests?type=paid';

  static const TOTAL_WORKING_HOUR = 8;
}

extension StringExtension on String {
  bool isUnique() {
    return true;
  }
}

void showToast(
  String message, {
  Color? backgroundColor,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: backgroundColor ?? Colors.white,
    textColor: Colors.black,
    fontSize: 12,
  );
}

Color transparent = Colors.transparent;
