import 'package:maca/function/app_function.dart';
import 'package:maca/store/local_store.dart';

class MacaAuth {
  Future<bool> loginChecking() async {
    // Await the Future to get the actual value.
    dynamic isLogin = await LocalStore().getStore(ListOfStoreKey.loginStatus);

    macaPrint(isLogin, "isLogin");

    // Return the resolved boolean value.
    return isLogin ?? false;
  }
}
