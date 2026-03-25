// {
//     "message": "Data retrieved successfully",
//     "status": 200,
//     "isSuccess": true,
//     "data": {
//         "status": "success"
//     }
// }

class UpdateUserDetailsResponse {
  final String message;
  final int status;
  final bool isSuccess;

  UpdateUserDetailsResponse({required this.message, required this.status, required this.isSuccess});

  factory UpdateUserDetailsResponse.fromJson(Map<String, dynamic> json) {
    return UpdateUserDetailsResponse(message: json['message'], status: json['status'], isSuccess: json['isSuccess']);
  }
}
