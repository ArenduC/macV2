import 'package:maca/features/admin/data/models/update_user_details_parameter.dart';
import 'package:maca/features/admin/data/models/update_user_details_response.dart';

abstract class UpdateUserDetailsRepo {
  Future<UpdateUserDetailsResponse> updateUserDetailsRepo(UpdateUserDetailsParameter body);
}
