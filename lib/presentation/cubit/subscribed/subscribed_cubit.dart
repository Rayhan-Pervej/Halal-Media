
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:halal_media/data/models/user_model.dart';
import 'package:halal_media/data/repositories/profile_repo.dart';

part 'subscribed_state.dart';

class SubscribedCubit extends Cubit<SubscribedState> {
  final ProfileRepo profileRepo;

  SubscribedCubit(this.profileRepo) : super(SubscribedInitial());

  Future<void> loadSubscribedUsers(String userId) async {
    emit(SubscribedLoading());
    try {
      final currentUser = await profileRepo.fetchUserProfile(id: userId);
      final allUsers = await profileRepo.fetchAllDemoUsers();

      final subscribedUsers = allUsers
          .where((user) => currentUser.subscribedTo.contains(user.id))
          .toList();

      emit(SubscribedLoaded(subscribedUsers));
    } catch (e) {
      emit(SubscribedError("Failed to load subscriptions."));
    }
  }

  Future<void> toggleSubscription(UserModel channel) async {
    if (state is! SubscribedLoaded) return;

    final currentState = state as SubscribedLoaded;
    final Set<String> loadingIds = {...currentState.loadingUserIds, channel.id};
    emit(SubscribedLoaded(currentState.subscribedUsers, loadingUserIds: loadingIds));

    await Future.delayed(const Duration(seconds: 1)); // Simulate server update

    // Remove from subscribed list to simulate unsubscription
    final updatedUsers = List<UserModel>.from(currentState.subscribedUsers)
      ..removeWhere((u) => u.id == channel.id);

    final Set<String> updatedLoadingIds = Set.from(loadingIds)..remove(channel.id);
    emit(SubscribedLoaded(updatedUsers, loadingUserIds: updatedLoadingIds));
  }
}

