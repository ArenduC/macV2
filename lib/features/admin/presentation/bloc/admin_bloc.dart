import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maca/common/snack_bar/enum/snack_bar_type.dart';
import 'package:maca/common/snack_bar/view/maca_snack_bar.dart';
import 'package:maca/features/admin/data/models/update_user_details_parameter.dart';
import 'package:maca/features/admin/data/models/update_user_details_response.dart';
import 'package:maca/features/admin/data/models/user_details_model.dart';
import 'package:maca/features/admin/domain/repositories/update_user_details_repo.dart';
import 'package:maca/features/admin/domain/repositories/user_details_repo.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  UserDetailsRepo userDetailsRepo;
  UpdateUserDetailsRepo updateUserDetailsRepo;
  AdminBloc(this.userDetailsRepo, this.updateUserDetailsRepo) : super(AdminInitial()) {
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
    final body = UpdateUserDetailsParameter(adminUserId: 24, newStatus: event.newStatus, newMStatus: event.newMStatus == "0" ? "1" : "0", newType: event.newType, targetUserId: event.targetUserId);

    try {
      final data = await updateUserDetailsRepo.updateUserDetailsRepo(body);

      if (state is AdminLoaded) {
        final currentState = state as AdminLoaded;

        final updatedList = currentState.allUserDetails.map((user) {
          if (user.userId == event.targetUserId) {
            return user.copyWith(
              userMarketingStatus: user.userMarketingStatus == "0" ? "1" : "0",
            );
          }
          return user;
        }).toList();

        if (event.context != null) {
          macaSnackBar(
            event.context!,
            SnackBarType.success,
            data.message,
          );
        }

        emit(AdminLoaded(updatedList)); // 🔥 No reload
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
