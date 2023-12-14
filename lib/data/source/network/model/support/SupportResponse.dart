import 'package:cnattendance/data/source/network/model/support/Data.dart';

class SupportResponse {
    Data data;
    String message;
    bool status;
    int status_code;

    SupportResponse({required this.data,required this.message,required this.status,required this.status_code});

    factory SupportResponse.fromJson(Map<String, dynamic> json) {
        return SupportResponse(
            data: Data.fromJson(json['data']),
            message: json['message'], 
            status: json['status'], 
            status_code: json['status_code'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['message'] = message;
        data['status'] = status;
        data['status_code'] = status_code;
          data['data'] = this.data.toJson();
        return data;
    }
}