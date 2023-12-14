import '../tadadetail/Data.dart';

class TadaDetailResponse {
    Data data;
    String message;
    bool status;
    int status_code;

    TadaDetailResponse({required this.data,required this.message,required this.status,required this.status_code});

    factory TadaDetailResponse.fromJson(Map<String, dynamic> json) {
        return TadaDetailResponse(
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