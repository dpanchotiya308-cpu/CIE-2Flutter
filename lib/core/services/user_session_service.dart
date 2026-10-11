import 'package:flutter/material.dart';

class UserProfile {
  String fullName;
  String email;
  String phone;
  String company;
  String? avatarPath;
  List<String> capabilities;

  UserProfile({
    this.fullName = 'Georgia Alfaro',
    this.email = 'excelmachinery@gmail.com',
    this.phone = '1234567890',
    this.company = 'Excel Machinery pvt.ltd',
    this.avatarPath = 'assets/images/user_avatar.png',
    List<String>? capabilities,
  }) : capabilities = capabilities ?? ['CNC', 'Lathe'];
}

class UserSessionService extends ChangeNotifier {
  static final UserSessionService _instance = UserSessionService._internal();
  factory UserSessionService() => _instance;
  UserSessionService._internal();

  final UserProfile currentProfile = UserProfile();

  void updateProfile({
    String? fullName,
    String? email,
    String? phone,
    String? company,
    String? avatarPath,
    List<String>? capabilities,
  }) {
    if (fullName != null && fullName.trim().isNotEmpty) {
      currentProfile.fullName = fullName.trim();
    }
    if (email != null && email.trim().isNotEmpty) {
      currentProfile.email = email.trim();
    }
    if (phone != null && phone.trim().isNotEmpty) {
      currentProfile.phone = phone.trim();
    }
    if (company != null && company.trim().isNotEmpty) {
      currentProfile.company = company.trim();
    }
    if (avatarPath != null) {
      currentProfile.avatarPath = avatarPath;
    }
    if (capabilities != null && capabilities.isNotEmpty) {
      currentProfile.capabilities = List<String>.from(capabilities);
    }
    notifyListeners();
  }
}
