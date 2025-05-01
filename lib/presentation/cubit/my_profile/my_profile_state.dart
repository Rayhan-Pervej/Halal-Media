part of 'my_profile_cubit.dart';

@immutable
sealed class MyProfileState {}

final class MyProfileInitial extends MyProfileState {}

class MyProfileLoading extends MyProfileState {}

class MyProfileFormState extends MyProfileState {
  final UserModel userData;
  final File? profileImage;
  final File? bannerImage;
  final TextEditingController channelNameController;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController handleController;
  final TextEditingController descriptionController;
  final TextEditingController channelUrlController;
  final bool isSavingLoading;

  MyProfileFormState({
    this.profileImage,
    this.bannerImage,
    required this.userData,
    required this.channelNameController,
    required this.nameController,
    required this.emailController,
    required this.handleController,
    required this.descriptionController,
    required this.channelUrlController,
     this.isSavingLoading =false,
  });

  MyProfileFormState copyWith({
    UserModel? userData,
    File? profileImage,
    File? bannerImage,
    TextEditingController? channelNameController,
    TextEditingController? nameController,
    TextEditingController? emailController,
    TextEditingController? handleController,
    TextEditingController? descriptionController,
    TextEditingController? channelUrlController,
    bool? isSavingLoading,
  }) {
    return MyProfileFormState(
      userData: userData ?? this.userData,
      profileImage: profileImage ?? this.profileImage,
      bannerImage: bannerImage ?? this.bannerImage,
      channelNameController:
          channelNameController ?? this.channelNameController,
      nameController: nameController ?? this.nameController,
      emailController: emailController ?? this.emailController,
      handleController: handleController ?? this.handleController,
      descriptionController:
          descriptionController ?? this.descriptionController,
      channelUrlController: channelUrlController ?? this.channelUrlController,
      isSavingLoading: isSavingLoading ?? this.isSavingLoading,
    );
  }
}

final class MyProfileError extends MyProfileState {
  final String message;
  MyProfileError(this.message);
}

class MyProfileSaving extends MyProfileState {}
