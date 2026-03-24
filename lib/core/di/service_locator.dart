import 'package:get_it/get_it.dart';
import 'package:maca/features/admin/data/data_sources/remote_user_details.dart';
import 'package:maca/features/admin/data/repositories/user_details_repo.dart';
import 'package:maca/features/admin/domain/repositories/user_details_repo.dart';
import 'package:maca/features/admin/presentation/bloc/admin_bloc.dart';

final getIt = GetIt.instance;

void serviceLocator() {
  //repo
  getIt.registerLazySingleton<UserDetailsRepo>(() => UserDetailsRepoImp(getIt()));

  //bloc
  getIt.registerLazySingleton<AdminBloc>(() => AdminBloc(getIt()));

  //data resource
  getIt.registerLazySingleton<RemoteUserDetails>(() => RemoteUserDetails());
}
