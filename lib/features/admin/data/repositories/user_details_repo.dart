import 'package:maca/features/admin/data/data_sources/remote_user_details.dart';
import 'package:maca/features/admin/data/models/user_details_model.dart';
import 'package:maca/features/admin/domain/repositories/user_details_repo.dart';

class UserDetailsRepoImp implements UserDetailsRepo {
  RemoteUserDetails remoteUserDetails;

  UserDetailsRepoImp(this.remoteUserDetails);

  @override
  Future<List<UserDetails>> getUserDetails() async {
    try {
      final data = await remoteUserDetails.fetchAllUserDetails();
      print("UserDetailsRepoImp $data");
      return data;
    } catch (e) {
      throw e.toString();
    }
  }
}
