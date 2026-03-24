part of 'admin_bloc.dart';

@immutable
sealed class AdminState {}

final class AdminInitial extends AdminState {}

final class AdminLoaded extends AdminState {
  final List<UserDetails> allUserDetails;

  AdminLoaded(this.allUserDetails);
}

final class AdminFailed extends AdminState {}
