import 'package:maca/features/admin/data/models/user_details_model.dart';

abstract class UserDetailsRepo {
  Future<List<UserDetails>> getUserDetails();
}
