import 'package:flutter/material.dart';
import 'package:news/core/models/user.dart';

class UserProvider with ChangeNotifier {
  UserModel? currentUser;
  void updateUser(UserModel? user) {
    currentUser = user;
    notifyListeners();
  }


}
