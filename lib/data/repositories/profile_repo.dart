import 'dart:async';
import 'package:halal_media/data/models/user_model.dart';

class ProfileRepo {
  final List<UserModel> _demoUsers = [
    UserModel(
      id: "101",
      name: 'John Doe',
      username: 'johndoe',
      email: 'john@example.com',
      channelName: 'JohnsChannel',
      description: 'Welcome to my channel about tech and life.',
      preferences: ['quran', 'hadith', 'seerah'],
      subscribedTo: ['102', '103'], // John follows Aisha and Ahmed
      subscribers: ['104'], // Fatima follows John
    ),
    UserModel(
      id: "102",
      name: 'Aisha Khan',
      username: 'aishak',
      email: 'aisha@example.com',
      channelName: 'Faith & Wellness',
      description: 'Sharing knowledge on Islam and mental health.',
      preferences: ['quran', 'islamic history', 'duas'],
      subscribedTo: ['103'],
      subscribers: ['101'],
    ),
    UserModel(
      id: "103",
      name: 'Ahmed Ali',
      username: 'ahmedali',
      email: 'ahmed@example.com',
      channelName: 'Tech4Deen',
      description: 'Where technology meets faith.',
      preferences: ['tech', 'quran apps', 'islamic gadgets'],
      subscribedTo: [],
      subscribers: ['101', '102'],
    ),
    UserModel(
      id: "104",
      name: 'Fatima Noor',
      username: 'fatimanoor',
      email: 'fatima@example.com',
      channelName: 'Peaceful Reflections',
      description: 'Daily reminders and reflections on the Quran.',
      preferences: ['tafseer', 'daily reminders', 'ramadan'],
      subscribedTo: ['103', '101', '102'],
      subscribers: [],
    ),
  ];

  UserModel? userData;

  Future<UserModel> fetchUserProfile({String id = '104'}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    userData = _demoUsers.firstWhere((user) => user.id == id);
    return userData!;
  }

  Future<void> updateUserProfile(UserModel updatedUser) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _demoUsers.indexWhere((user) => user.id == updatedUser.id);
    if (index != -1) {
      _demoUsers[index] = updatedUser;
    }
    userData = updatedUser;
  }

  Future<List<UserModel>> fetchAllDemoUsers() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _demoUsers;
  }
}
