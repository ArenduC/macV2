import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maca/features/admin/data/models/user_details_model.dart';
import 'package:maca/features/admin/domain/repositories/user_details_repo.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  UserDetailsRepo userDetailsRepo;
  AdminBloc(this.userDetailsRepo) : super(AdminInitial()) {
    on<LoadUserDetails>(_onAllUserDetails);
    on<UserStatusUpdate>(_onUserStatusUpdate);
  }

  @override
  void onChange(Change<AdminState> change) {
    super.onChange(change);
    print("AllUserDetails $change");
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print("AllUserDetails $error");
    super.onError(error, stackTrace);
  }

  void _onAllUserDetails(LoadUserDetails event, Emitter<AdminState> emit) async {
    emit(AdminInitial());

    try {
      final data = await userDetailsRepo.getUserDetails();

      emit(AdminLoaded(data));
    } catch (e) {
      emit(AdminFailed());
      throw e.toString();
    }
  }

  Future<void> _onUserStatusUpdate(UserStatusUpdate event, Emitter<AdminState> emit) async {
    final targetUserId = event.targetUserId;
    final newStatus = event.newStatus;
    final adminUserId = event.adminUserId;

    try {
      print("$targetUserId");
    } catch (e) {
      throw e.toString();
    }
  }
}
