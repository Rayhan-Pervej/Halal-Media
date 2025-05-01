import 'package:halal_media/domain/entities/user.dart';

class UserModel {
  final String id;
  final String name;
  final String? username;
  final String email;
  final String channelName;
  final String description;
  final List<String> preferences;

  final List<String> subscribedTo;
  final List<String> subscribers;  

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.channelName,
    this.username,
    required this.description,
    this.preferences = const [],
    this.subscribedTo = const [],
    this.subscribers = const [],
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? 'Unknown',
      email: json['email'] ?? '',
      channelName: json['channelName'] ?? '',
      description: json['description'] ?? '',
      preferences: (json['preferences'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      subscribedTo: (json['subscribedTo'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      subscribers: (json['subscribers'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'channelName': channelName,
      'description': description,
      'preferences': preferences,
      'subscribedTo': subscribedTo,
      'subscribers': subscribers,
    };
  }

  User toEntity() => User(id: id, email: email, name: name);
}
