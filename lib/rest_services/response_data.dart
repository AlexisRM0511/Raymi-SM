class ResponseData {
  int status;
  dynamic data;
  String? message;

  ResponseData({required this.status, this.data, this.message});

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
      status: json["status"] as int,
      data: (json["data"] != null) ? json["data"] as dynamic : null,
      message: (json["message"] != null) ? json["message"] as String : null);

  @override
  String toString() {
    return 'ResponseData{status: $status, data: $data, message: $message}';
  }
}
