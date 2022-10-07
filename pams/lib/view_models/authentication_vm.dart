import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pams/models/future_manager.dart';
import 'package:pams/models/login_response_model.dart';
import 'package:pams/providers/auth_provider.dart';
import 'package:pams/view_models/base_vm.dart';
import 'package:pams/views/homepage.dart';
import 'package:get/get.dart';

class AuthViewModel extends BaseViewModel {
  final Reader reader;
  GetStorage box = GetStorage();
  GetStorage userdata = GetStorage();

  FutureManager<LoginResponseModel> userData = FutureManager();

  AuthViewModel(this.reader) : super(reader);

  userLoginService({required String email, required String password}) async {
    userData.load();
    notifyListeners();
    final res = await reader(authServiceProvider).userLogin(email: email, password: password);
    if (res.status == true) {
      Get.offAll(() => HomeView());
      userData.onSuccess(res);
      box.write('token', res.returnObject!.token!);
      userdata.write('name', res.returnObject!.fullname);
      userdata.write('email', res.returnObject!.email);
      userdata.write('role', res.returnObject!.role![0]);
      notifyListeners();
    } else {
      userData.onError('Error');
      notifyListeners();
    }
  }
}
