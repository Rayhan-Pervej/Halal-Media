import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halal_media/data/models/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:halal_media/data/repositories/profile_repo.dart'; // <-- Add repo import if needed

part 'my_profile_state.dart';

class MyProfileCubit extends Cubit<MyProfileState> {
  final ProfileRepo profileRepo; // <-- Injected Repo

  MyProfileCubit(this.profileRepo) : super(MyProfileInitial());

  final ImagePicker _picker = ImagePicker();

  // 🛠️ Fetch User Data and Populate Controllers
  Future<void> userData() async {
    try {
      emit(MyProfileLoading());

      final user = await profileRepo.fetchUserProfile(); // Demo ID

      final newState = MyProfileFormState(
        userData: user,
        profileImage: null,
        bannerImage: null,
        isSavingLoading: false,
        channelNameController: TextEditingController(text: user.channelName),
        nameController: TextEditingController(text: user.name),
        emailController: TextEditingController(text: user.email),
        handleController: TextEditingController(),
        descriptionController: TextEditingController(text: user.description),
        channelUrlController: TextEditingController(),
      );

      emit(newState);
    } catch (e) {
      emit(MyProfileError(e.toString()));
    }
  }

  // 🛠️ Pick Profile Image
  Future<void> pickProfileImage() async {
    try {
      final picked = await _picker.pickImage(source: ImageSource.gallery);
      if (picked != null && state is MyProfileFormState) {
        emit(
          (state as MyProfileFormState).copyWith(
            profileImage: File(picked.path),
          ),
        );
      }
    } catch (e) {
      emit(MyProfileError(e.toString()));
    }
  }

  // 🛠️ Pick Banner Image
  Future<void> pickBannerImage() async {
    try {
      final picked = await _picker.pickImage(source: ImageSource.gallery);
      if (picked != null && state is MyProfileFormState) {
        emit(
          (state as MyProfileFormState).copyWith(
            bannerImage: File(picked.path),
          ),
        );
      }
    } catch (e) {
      emit(MyProfileError(e.toString()));
    }
  }

  // 🛠️ Optional: Save User Profile back

  Future<void> saveUserProfile() async {
    try {
      if (state is MyProfileFormState) {
        final currentState = state as MyProfileFormState;
        print("button pressed");
        // Emit saving state to show the progress indicator
        emit(currentState.copyWith(isSavingLoading: true));
        await Future.delayed(Duration(seconds: 2));
        final updatedUser = UserModel(
          
          id: currentState.userData.id,
          name: currentState.nameController.text,
          email: currentState.emailController.text,
          channelName: currentState.channelNameController.text,
          description: currentState.descriptionController.text,
        );

        // Simulate an API call to save the profile
        await profileRepo.updateUserProfile(updatedUser);

        // After saving, restore the form state with updated user data
        emit(
          currentState.copyWith(userData: updatedUser, isSavingLoading: false),
        );
      }
    } catch (e) {
      emit(MyProfileError(e.toString()));
    }
  }
}
