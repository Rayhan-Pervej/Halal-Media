part of 'subscribed_cubit.dart';

@immutable
sealed class SubscribedState {}

final class SubscribedInitial extends SubscribedState {}

final class SubscribedLoading extends SubscribedState {}

final class SubscribedLoaded extends SubscribedState {
  final List<UserModel> subscribedUsers;
  final Set<String> loadingUserIds;

  SubscribedLoaded(this.subscribedUsers, {this.loadingUserIds = const {}});
}


final class SubscribedError extends SubscribedState {
  final String message;

  SubscribedError(this.message);
}
