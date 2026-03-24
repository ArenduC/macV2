part of 'admin_bloc.dart';

@immutable
sealed class AdminEvent {}

class LoadUserDetails extends AdminEvent {}

class UserStatusUpdate extends AdminEvent {
  //target_user_id INT,
  // new_status INT,
  // admin_user_id INT

  //   target_user_id INT,
  // new_status INT,
  // new_type INT,
  // new_m_status TEXT,
  // admin_user_id INT

  final int targetUserId;
  final int newStatus;
  final int newType;
  final String newMStatus;
  final int? adminUserId;

  UserStatusUpdate(this.targetUserId, this.newStatus, this.newType, this.newMStatus, {this.adminUserId});
}

class UserRoleUpdate extends AdminEvent {}
