import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/api_service.dart';
import '../../utils/shared_service.dart';
import '../state/user_state.dart';

class UserNotifier extends StateNotifier<userState> {
  final ApiService appService;
  UserNotifier(this.appService) : super(const userState()) {
    getUser();
  }
  Future<void> getUser() async {
    state = state.copyWith(isLoading: true);
    final loginDetails = await SharedService.loginDetails();
    state=state.copyWith(userModel: loginDetails!.data);
    state = state.copyWith(isLoading: false);
  }
 
}
