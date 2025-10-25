import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/user.dart';

class ProfileProvider extends ChangeNotifier {
  final Box<UserProfile> _profileBox = Hive.box<UserProfile>('userProfile');

  UserProfile get userProfile {
    if (_profileBox.isEmpty) {
      _profileBox.put(0, UserProfile());
    }
    return _profileBox.get(0)!;
  }

  void updateProfile(UserProfile profile) {
    _profileBox.put(0, profile);
    notifyListeners();
  }
}
