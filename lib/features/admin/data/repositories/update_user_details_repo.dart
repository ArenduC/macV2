import 'package:maca/features/admin/data/data_sources/remote_update_user_details.dart';
import 'package:maca/features/admin/data/models/update_user_details_parameter.dart';
import 'package:maca/features/admin/data/models/update_user_details_response.dart';
import 'package:maca/features/admin/domain/repositories/update_user_details_repo.dart';

class UpdateUserDetailsRepoImp implements UpdateUserDetailsRepo {
  RemoteUpdateUserDetails remoteUpdateUserDetails;

  UpdateUserDetailsRepoImp(this.remoteUpdateUserDetails);

  @override
  Future<UpdateUserDetailsResponse> updateUserDetailsRepo(UpdateUserDetailsParameter body) async {
    try {
      final data = remoteUpdateUserDetails.updateUserStatus(body);
      return data;
    } catch (e) {
      throw Exception(e);
    }
  }
}
